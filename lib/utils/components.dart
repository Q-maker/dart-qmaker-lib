import 'package:qcmcore/entities/exercise.dart';
import 'package:qcmcore/models/model_utils.dart';

abstract class Evaluator<T> {
  bool equals(T item1, T item2);
}

class FunctionEvaluator<T> extends Evaluator<T> {
  final bool Function(T item1, T item2) _function;

  FunctionEvaluator(this._function);

  @override
  bool equals(T item1, T item2) {
    return _function(item1, item2);
  }

}

abstract class RatingTypeHandler {
  /**
   * Les point atomique, sans coefficient que l'on expert obtenir au total pour cet exercise.
   *
   * @param exercise
   * @return
   */
  int getExpectedRawMarks(Exercise exercise);

  int getExpectedSuccessCount(Exercise exercise);

  /**
   * Ce type d'exercise, accepte t'il des réponse partielle ou l'exercisé doit imperativement trouver toute les réponses.
   *
   * @param exercise
   * @return
   */
  bool isAllowPartialSuccess(Exercise exercise);
}

class FunctionRatingTypeHandler extends RatingTypeHandler{

  Provider<Exercise, int> rawMarksGetter, expectedSuccessCountGetter;
  Provider<Exercise, bool> allowPartialSuccessStateGetter;

  FunctionRatingTypeHandler({required this.rawMarksGetter, required this.expectedSuccessCountGetter, required this.allowPartialSuccessStateGetter});


  @override
  int getExpectedRawMarks(Exercise exercise) {
    // TODO: implement getExpectedRawMarks
    throw UnimplementedError();
  }

  @override
  int getExpectedSuccessCount(Exercise exercise) {
    // TODO: implement getExpectedSuccessCount
    throw UnimplementedError();
  }

  @override
  bool isAllowPartialSuccess(Exercise exercise) {
    // TODO: implement isAllowPartialSuccess
    throw UnimplementedError();
  }
  
}