import 'package:flutter/material.dart';
import 'package:childnames/service.dart';
import 'package:childnames/response.dart';

void main() => runApp(const ChildName());

class ChildName extends StatefulWidget {
  const ChildName({Key? key}) : super(key: key);

  @override
  State<ChildName> createState() => _ChildNameState();
}

class _ChildNameState extends State<ChildName> {
  final ApiService apiService = ApiService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _musicStyleController = TextEditingController();
  final TextEditingController _movieCategoryController =
      TextEditingController();
  bool _haveSuggestions = false;
  late final List<Map<String, Object>> _names;

  @override
  void dispose() {
    // Limpar os controladores ao finalizar
    _countryController.dispose();
    _genderController.dispose();
    _musicStyleController.dispose();
    _movieCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Child Names",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Suggestion for children's names"),
            ),
            body: _haveSuggestions
                ? Response(
                    names: _names,
                    onRestartQuiz: restart,
                  )
                : SingleChildScrollView(
                    child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 22),
                        child: Column(
                          children: [
                            const Center(
                              heightFactor: 1,
                              child: Text(
                                  "Need help choosing your child's name? You are in the right place! I just need some information, fill out the form below and click the button and I'll be happy to help.",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  )),
                            ),
                            const Divider(
                              height: 20,
                              thickness: 3,
                              indent: 10,
                              endIndent: 10,
                              color: Colors.blue,
                            ),
                            const Center(
                              heightFactor: 1.5,
                              child: Text("Fill in all fields.",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 36,
                                    color: Colors.black,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: TextFormField(
                                controller: _countryController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Country",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: TextFormField(
                                controller: _genderController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Gender",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter gender';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: TextFormField(
                                controller: _musicStyleController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Music Style",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Music Style';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: TextFormField(
                                controller: _movieCategoryController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Movie Category",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter movie category';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final country = _countryController.text;
                                      final gender = _genderController.text;
                                      final musicStyle =
                                          _musicStyleController.text;
                                      final movieCategory =
                                          _movieCategoryController.text;

                                      fetchDataFromApi(country, gender,
                                          musicStyle, movieCategory);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(300, 10),
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.all(20),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ))));
  }

  void fetchDataFromApi(country, gender, musicStyle, movieCategory) async {
    try {
      Map<String, dynamic> data = await apiService.fetchData(
          country, gender, musicStyle, movieCategory);

      List<Map<String, Object>> names = data.entries.map((entry) {
        return {
          entry.key: entry.value as Object,
        };
      }).toList();

      _names = names;
      setState(() {
        _haveSuggestions = true;
      });

      _formKey.currentState!.reset();
    } catch (e) {
      // Lida com o erro da requisição
      print('Erro na chamada da API: $e');
    }
  }

  void restart() {
    setState(() {
      _haveSuggestions = false;
    });
  }
}
