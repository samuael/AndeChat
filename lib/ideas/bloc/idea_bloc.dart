import 'package:ChatUI/libs.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Bloc IdeaBloc maps the user event with the corresponding new state
class IdeaBloc extends Bloc<IdeaEvent, IdeaState> implements Cubit<IdeaState> {
  final Idearepository idearepository;

  IdeaBloc({@required this.idearepository})
      : assert(idearepository != null),
        super(IdeaLoading());

  @override
  Stream<IdeaState> mapEventToState(IdeaEvent event) async* {
    if (event is IdeaCreate) {
      try {
        await idearepository.createIdea(event.idea);

        final ideas = await idearepository.getideas(StaticDataStore.ID);
        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaLoadMoney) {
      // yield IdeaLoading();
      try {
        final ideas = await idearepository.getideasMoney();

        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaLoad) {
      // yield IdeaLoading();
      try {
        final ideas = await idearepository.getideas(StaticDataStore.ID);

        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaUpdate) {
      try {
        await idearepository.updateIdea(event.idea);
        final ideas = await idearepository.getideas(StaticDataStore.ID);
        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaDelete) {
      try {
        await idearepository.deleteIdea(event.idea.id);
        final ideas = await idearepository.getideas(StaticDataStore.ID);
        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }
  }

  Stream<IdeaState> getMyIdeas() async* {
    try {
      final ideas = await idearepository.getideas(StaticDataStore.ID);
      print(ideas);
      yield IdeaLoadSuccess(ideas);
    } catch (_) {
      yield IdeaOperationFailure();
    }
  }
}
