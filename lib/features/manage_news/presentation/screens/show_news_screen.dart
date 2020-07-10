import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redeap/core/widgets/my_app_bar.dart';
import 'package:redeap/core/widgets/my_drawer.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_bloc.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_event.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_state.dart';
import 'package:redeap/features/manage_news/presentation/screens/create_news_screen.dart';
import 'package:redeap/injection_container.dart';

class ShowNewsScreen extends StatelessWidget {
  final Params ctx = Params();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: SingleChildScrollView(child: buildBody( context )),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
//        onPressed: () => Navigator.pushNamed(context, 'createNews'),
          onPressed: () =>Navigator.of( ctx.bloc ).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<NewsBloc>( ctx.bloc ),
                  child: CreateNewsScreen()
              ),
            ),
          )
      )
    );
  }

  BlocProvider<NewsBloc> buildBody( BuildContext context ) {

    return BlocProvider<NewsBloc>(
      builder: (context) => di<NewsBloc>(),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            BlocBuilder<NewsBloc, NewsState>(
              builder: ( context, state ) {

                ctx.bloc = context;

                if( state is Empty ) {
                  return Container(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: RefreshIndicator(
                            onRefresh:  () async {
                              await Future.delayed( Duration( seconds: 2) );
                              BlocProvider.of<NewsBloc>( context ).dispatch(GetNewsForUser());
                            },
                          child: ListView(
                            children: <Widget>[
                              Center(
                                  child: Text('No hay lista de novedades')
                              ),

                            ],
                          ),
                        ),
                      )
                  );
                } else if( state is Loading ) {
                  return Container(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: CircularProgressIndicator(),
                      )
                  );
                } else if( state is Loaded ) {
                  return RefreshIndicator(
                    onRefresh:  () async {
                      await Future.delayed( Duration( seconds: 2) );
                      BlocProvider.of<NewsBloc>( context ).dispatch(GetNewsForUser());
                    },
                    child: ListView.builder(
                        padding: const EdgeInsets.all( 16 ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.newsList.length,
                        itemBuilder: ( _, int index ) {

                          return Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20,),
                                Center(
                                  child: Text('${state.newsList[index].unitCode} en ${state.newsList[index].message}')
                                ),
                                Divider()
                              ],
                            ),
                          );
                        }
                    ),
                  );
                } else if( state is Error) {
                  return Container(
                      height: MediaQuery.of(context).size.height/3,
                      child: Center(
                        child: Text( state.message ),
                      )
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Params {
   BuildContext context;
   get bloc => context;
   set bloc( BuildContext c ) => context=c;
}