import 'package:bloc/bloc.dart';
import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_core_model/tools/base/model_base.dart';
import 'package:eliud_core_model/tools/base/repository_base.dart';
import 'package:eliud_core_model/tools/component/component_spec.dart';

import 'editor_base_event.dart';
import 'editor_base_state.dart';

abstract class EditorBaseBloc<T extends ModelBase, U>
    extends Bloc<EditorBaseEvent<T>, EditorBaseState<T>> {
  final String appId;
  final RepositoryBase<T, U> repository;
  final EditorFeedback feedback;

  T newInstance(StorageConditionsModel conditions);
  T setDefaultValues(T t, StorageConditionsModel conditions);

  EditorBaseBloc(this.appId, this.repository, this.feedback)
      : super(EditorBaseUninitialised()) {
    on<EditorBaseInitialise<T>>((event, emit) async {
      // retrieve the model, as it was retrieved without links
      var modelWithLinks = await repository.get(event.model.documentID);
      if (modelWithLinks == null) {
        modelWithLinks = newInstance(
          StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
        );
      } else {
        modelWithLinks = setDefaultValues(
            modelWithLinks,
            StorageConditionsModel(
                privilegeLevelRequired:
                    PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple));
      }
      emit(EditorBaseInitialised(
        model: modelWithLinks,
      ));
    });
  }

  Future<void> save(EditorBaseApplyChanges event) async {
    if (state is EditorBaseInitialised) {
      var theState = state as EditorBaseInitialised;
      var newModel = theState.model;
      if (await repository.get(newModel.documentID) == null) {
        await repository.add(newModel);
      } else {
        await repository.update(newModel);
      }
      feedback(true, newModel);
    }
  }
}
