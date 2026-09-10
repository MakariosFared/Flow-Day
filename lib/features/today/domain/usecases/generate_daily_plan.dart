import '../../../../core/planning/planning_contracts.dart';
import '../repositories/schedule_repository.dart';

class GenerateDailyPlan {
  const GenerateDailyPlan(this._engine, this._scheduleRepository);
  final PlanningEngine _engine;
  final ScheduleRepository _scheduleRepository;

  Future<PlanningResult> call(PlanningRequest request) async {
    final result = _engine.plan(request);
    await _scheduleRepository.replaceAutomaticBlocks(
      request.date,
      result.blocks,
    );
    return result;
  }
}
