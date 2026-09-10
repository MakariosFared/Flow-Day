import 'package:uuid/uuid.dart';

import '../../../../core/clock/clock.dart';
import '../../../../core/errors/failures.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/domain/repositories/task_repository.dart';
import '../entities/schedule_block.dart';
import '../repositories/schedule_repository.dart';

class StartFocus {
  const StartFocus(this._taskRepo, this._focusRepo, this._clock);
  final TaskRepository _taskRepo;
  final FocusSessionRepository _focusRepo;
  final Clock _clock;

  Future<FocusSession> call(String taskId) async {
    final task = await _taskRepo.getById(taskId);
    if (task == null) {
      throw NotFoundFailure('Task not found: $taskId');
    }

    final now = _clock.now();

    // If task is not yet inProgress, transition it
    if (task.status != TaskStatus.inProgress) {
      if (!task.canTransitionTo(TaskStatus.inProgress)) {
        throw ValidationFailure(
          'Cannot start focus on task in status: ${task.status.name}',
        );
      }
      await _taskRepo.save(
        task.copyWith(status: TaskStatus.inProgress, updatedAt: now),
      );
    }

    // Check if there is an existing active or paused session
    final existingSession = await _focusRepo.getActiveOrPausedSession(taskId);
    if (existingSession != null) {
      if (existingSession.state == FocusSessionState.active) {
        return existingSession; // Already active
      }
      // If paused, resume it
      final resumed = existingSession.copyWith(
        state: FocusSessionState.active,
        startedAt: now,
        pausedAt: null,
      );
      await _focusRepo.save(resumed);
      return resumed;
    }

    // Create a new focus session
    final session = FocusSession(
      id: const Uuid().v4(),
      taskId: taskId,
      state: FocusSessionState.active,
      startedAt: now,
      activeDuration: Duration.zero,
    );

    await _focusRepo.save(session);
    return session;
  }
}

class PauseFocus {
  const PauseFocus(this._taskRepo, this._focusRepo, this._clock);
  final TaskRepository _taskRepo;
  final FocusSessionRepository _focusRepo;
  final Clock _clock;

  Future<FocusSession> call(String taskId) async {
    final session = await _focusRepo.getActiveOrPausedSession(taskId);
    if (session == null) {
      throw NotFoundFailure('No active focus session found for task: $taskId');
    }

    if (session.state == FocusSessionState.paused) {
      return session; // Already paused
    }

    final now = _clock.now();
    final elapsedSinceStart = now.difference(session.startedAt);
    final newActiveDuration =
        session.activeDuration +
        (elapsedSinceStart.isNegative ? Duration.zero : elapsedSinceStart);

    final pausedSession = session.copyWith(
      state: FocusSessionState.paused,
      pausedAt: now,
      activeDuration: newActiveDuration,
    );

    await _focusRepo.save(pausedSession);

    // CRITICAL ARCHITECTURAL DECISION:
    // When focus is paused, Task status remains inProgress.
    // We update Task.actualDuration with current accumulated active time without changing status!
    final task = await _taskRepo.getById(taskId);
    if (task != null) {
      await _taskRepo.save(
        task.copyWith(actualDuration: newActiveDuration, updatedAt: now),
      );
    }

    return pausedSession;
  }
}

class ResumeFocus {
  const ResumeFocus(this._focusRepo, this._clock);
  final FocusSessionRepository _focusRepo;
  final Clock _clock;

  Future<FocusSession> call(String taskId) async {
    final session = await _focusRepo.getActiveOrPausedSession(taskId);
    if (session == null) {
      throw NotFoundFailure('No focus session found for task: $taskId');
    }

    if (session.state == FocusSessionState.active) {
      return session; // Already active
    }

    final now = _clock.now();
    final resumedSession = session.copyWith(
      state: FocusSessionState.active,
      startedAt: now,
      pausedAt: null,
    );

    await _focusRepo.save(resumedSession);
    return resumedSession;
  }
}

class CompleteFocus {
  const CompleteFocus(this._taskRepo, this._focusRepo, this._clock);
  final TaskRepository _taskRepo;
  final FocusSessionRepository _focusRepo;
  final Clock _clock;

  Future<Task> call(String taskId) async {
    final task = await _taskRepo.getById(taskId);
    if (task == null) {
      throw NotFoundFailure('Task not found: $taskId');
    }

    final now = _clock.now();
    var finalActiveDuration = task.actualDuration;

    final session = await _focusRepo.getActiveOrPausedSession(taskId);
    if (session != null) {
      if (session.state == FocusSessionState.active) {
        final elapsed = now.difference(session.startedAt);
        finalActiveDuration =
            session.activeDuration +
            (elapsed.isNegative ? Duration.zero : elapsed);
      } else {
        finalActiveDuration = session.activeDuration;
      }

      final completedSession = session.copyWith(
        state: FocusSessionState.completed,
        endedAt: now,
        activeDuration: finalActiveDuration,
      );
      await _focusRepo.save(completedSession);
    }

    final completedTask = task.copyWith(
      status: TaskStatus.completed,
      completedAt: now,
      actualDuration: finalActiveDuration,
      updatedAt: now,
    );
    await _taskRepo.save(completedTask);
    return completedTask;
  }
}
