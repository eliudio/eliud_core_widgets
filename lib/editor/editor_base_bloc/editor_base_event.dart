import 'package:eliud_core_model/tools/base/model_base.dart';
import 'package:equatable/equatable.dart';

abstract class EditorBaseEvent<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditorBaseInitialise<T extends ModelBase> extends EditorBaseEvent<T> {
  final T model;

  EditorBaseInitialise(this.model);

  @override
  List<Object?> get props => [model];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditorBaseInitialise && model == other.model;

  @override
  int get hashCode => model.hashCode;
}

class EditorBaseApplyChanges<T> extends EditorBaseEvent<T> {
  final T model;

  EditorBaseApplyChanges({required this.model});

  @override
  List<Object?> get props => [
        model,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditorBaseApplyChanges && model == other.model;

  @override
  int get hashCode => model.hashCode;
}
