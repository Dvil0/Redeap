import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redeap/core/route/router.dart';
import 'package:redeap/core/widgets/my_app_bar.dart';
import 'package:redeap/core/widgets/my_drawer.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_bloc.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_event.dart';
import 'package:redeap/features/manage_news/presentation/bloc/news_state.dart';
import 'package:redeap/injection_container.dart';
import 'package:redeap/core/utils/utils.dart';

class ShowNewsScreen extends StatefulWidget {
  @override
  _ShowNewsScreenState createState() => _ShowNewsScreenState();
}

class _ShowNewsScreenState extends State<ShowNewsScreen> {
  BuildContext blocContext;
  final newsBloc = di<NewsBloc>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: SingleChildScrollView(child: buildBody(context)),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _showCreateNews,
        ),
    );
  }

  BlocProvider<NewsBloc> buildBody(BuildContext context) {
    return BlocProvider<NewsBloc>(
      builder: (_) => newsBloc,
      child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              blocContext = context;

              if (state is Empty) {
                return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 2));
                          BlocProvider.of<NewsBloc>(context)
                              .dispatch(GetNewsForUser());
                        },
                        child: ListView(
                          children: <Widget>[
                            SizedBox( height: MediaQuery.of(context).size.height/3,),
                            Center(child: Text('No hay lista de novedades')),
                          ],
                        ),
                      ),
                    ));
              } else if (state is Loading) {
                return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else if (state is Loaded) {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.newsList.length,
                    itemBuilder: (_, int index) {
                      final listIndex = index;
                      return InkWell(
                        onTap: () => null,
                        child: Column(
                          children: <Widget>[
                            Row(
                            children: <Widget>[
                              Expanded(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        child: Text('${state.newsList[listIndex].unitCode[0]}')
                                    ),
                                    title: Text('${state.newsList[listIndex].unitCode}'),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(  Utils.convertToDate( state.newsList[listIndex].hourDate ) ),
                                    subtitle: Text('por: ${state.newsList[listIndex].unitCreate}'),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'En ${state.newsList[listIndex].message}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                      );

                    });
              } else if (state is Error) {
                return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Center(
                      child: Text(state.message),
                    ));
              }
              return Container();
            },
      ),
    );
  }

  void _showCreateNews() {
    Navigator.pushNamed(context, Router.CREATE_NEWS, arguments: newsBloc);
  }
}
