import 'package:fibonacci/service/fibonacci.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder:
          (context) => MaterialApp(
            title: 'Fibonacci',
            theme: ThemeData.dark(),
            home: FibonacciPage(),
          ),
    );
  }
}

class FibonacciPage extends StatefulWidget {
  const FibonacciPage({super.key});

  @override
  State<FibonacciPage> createState() => _FibonacciPageState();
}

class _FibonacciPageState extends State<FibonacciPage> {
  BigInt _fibonacci = BigInt.zero;
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _textFieldKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([_textFieldKey, _buttonKey]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fibonacci',
          style: TextStyle(
            color: Colors.purple,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Qual número da sequência de Fibonacci você deseja saber? (Começando em 1)',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Showcase(
                    key: _textFieldKey,
                    title: "Como usar ?",
                    description:
                        "Digite o número da sequência de Fibonacci. Deve ser maior que 0.",
                    scaleAnimationDuration: Duration(milliseconds: 150),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Número',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Showcase.withWidget(
                      key: _buttonKey,
                      height: 250,
                      width: 400,
                      blurValue: 0.3,
                      container: Container(
                        padding: EdgeInsets.all(8.00),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Como usar ?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Clique no botão para calcular o número da sequência de Fibonacci',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ShowCaseWidget.of(context).dismiss();
                              },
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 25, vertical: 5,)),
                                backgroundColor: WidgetStateProperty.all(Colors.purple),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Text('Entendi!', style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (int.parse(_controller.text) <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Número inválido'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          setState(() {
                            _fibonacci = dynamicFibonacci(int.parse(_controller.text));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: Text('Calcular'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Resultado: $_fibonacci',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
