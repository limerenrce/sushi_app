import 'package:flutter/material.dart';
import 'package:sushi_app/dto/news.dart';
import 'package:sushi_app/services/data_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<News>>? _news;

  late String _title;
  late String _body;
  bool isUpdate = false;
  late int? newsIdForUpdate;
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _news = DataService.fetchNews();
  }

  void _addFormNews(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add News'),
          content: Form(
            key: _formStateKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Body'),
                  controller: _bodyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter body';
                    }
                    return null;
                  },
                  onSaved: (value) => _body = value!,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formStateKey.currentState!.validate()) {
                  _formStateKey.currentState!.save();
                  _addNews(context, _title, _body);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNews(BuildContext context, String title, String body) {
    DataService.addNews(title, body).then((value) {
      setState(() {
        _news = DataService.fetchNews();
      });
      _titleController.clear();
      _bodyController.clear();
    }).catchError((error) {
      print('Failed to add news: $error');
      // Handle error
    });
  }

  void _editFormNews(BuildContext context, News news) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit News'),
          content: Form(
            key: _formStateKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController..text = news.title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Body'),
                  controller: _bodyController..text = news.body,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter body';
                    }
                    return null;
                  },
                  onSaved: (value) => _body = value!,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formStateKey.currentState!.validate()) {
                  _formStateKey.currentState!.save();
                  _editNews(context, news.id, _title, _body);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editNews(BuildContext context, String id, String title, String body) {
    DataService.editNews(id, title, body).then((value) {
      setState(() {
        _news = DataService.fetchNews();
      });
      _titleController.clear();
      _bodyController.clear();
    }).catchError((error) {
      print('Failed to edit news: $error');
      // Handle error
    });
  }

  void _deleteNews(BuildContext context, String id) {
    DataService.deleteNews(id).then((value) {
      setState(() {
        _news = DataService.fetchNews();
      });
    }).catchError((error) {
      print('Failed to delete news: $error');
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        title: const Text("Fetch Data News"),
        elevation: 0,
      ),
      body: Center(
        child: FutureBuilder<List<News>>(
          future: _news,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    onTap: () {
                      _editFormNews(context, post);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteNews(context, post.id);
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // Show a loading indicator while waiting for data
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addFormNews(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
