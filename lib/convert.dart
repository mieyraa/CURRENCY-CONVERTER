import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ConvertPage extends StatelessWidget {
  const ConvertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF212936),
        body: HomePage()
    );
  }
}
class HomePage extends StatefulWidget {
   const HomePage({ Key? key }) : super(key: key);
  @override

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController numEditingController = TextEditingController();

  String desc="No result";
  String rate= "Result";
  var MYR, KRW, result, JPY, GBP, USD, EUR;
 
  String selectFrom = "EUR";
  List<String> fromList = [
      "EUR",
      "GBP",
      "JPY",
      "KRW",
      "MYR",
      "USD",    
  ];
  String selectTo = "EUR";
  List<String> toList = [
      "EUR",
      "GBP",
      "JPY",
      "KRW",
      "MYR",
      "USD",  
  ];

  @override
  Widget build(BuildContext context) {
 
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [      
              const SizedBox(height: 25),
              const Text("CURRENCY",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue)
              ),
              const Text("CONVERTER APP",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue)
              ),
              const SizedBox(height: 40),
                TextField(
                  inputFormatters: [
                   FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                  ],
                  controller: numEditingController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration( 
                       filled: true,
                       fillColor: Colors.white,
                       hintText: "Input value (in number)",
                       border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0))), 
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        itemHeight: 60,
                        value: selectFrom,
                        onChanged: (newValue){
                        setState(() {
                        selectFrom = newValue.toString();
                });
              },
               items: fromList.map((selectFrom) {
                 return DropdownMenuItem(
                         child: Text(
                            selectFrom,
                         ),
                         value: selectFrom,
                 );
               }).toList(),
              ),
              FloatingActionButton(
                onPressed: () {
                  String temp = selectFrom;
                  setState(() {
                    selectFrom = selectTo;
                    selectTo = temp;
                  });
                },
               child: const Icon(Icons.swap_horiz),
             ),

              DropdownButton(
              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              itemHeight: 60,
              value: selectTo,
              onChanged: (newValue){
                setState(() {
                    selectTo = newValue.toString();
                  
                });
              },
               items: toList.map((selectTo) {
                 return DropdownMenuItem(
                     child: Text(
                       selectTo,
                     ),
                     value: selectTo,
                 );
               }).toList(),
              ),
                    ],
               ),
                  ),
                  Align( 
                    alignment: Alignment.center,
                    child:ElevatedButton(
                      onPressed:
                          _loadCurrency, 
                          child: const Text("CONVERT", 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF212936))),    
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(170, 45),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))        
                  ))),
                  const SizedBox(height: 20), 
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),  
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(rate,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              ) ),
                          ),
                          const SizedBox(height: 5),
                          Text(desc, style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold, 
                            )),   
                       ]     
                  )),     
          ],
        ),
      ),
    );
  }

    Future<void> _loadCurrency() async {

      var apiid = "ead87c60-386a-11ec-84c3-8f96c79b2946";
      var url = Uri.parse('https://freecurrencyapi.net/api/v2/latest?apikey=$apiid&base_currency=$selectFrom');
      var response = await http.get(url);
      var rescode = response.statusCode;
      
      setState( () {
         if(rescode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        KRW = parsedJson['data']['KRW'];
        GBP = parsedJson['data']['GBP'];
        JPY = parsedJson['data']['JPY'];
        USD = parsedJson['data']['USD'];
        MYR = parsedJson['data']['MYR'];
        EUR = parsedJson['data']['EUR'];
        
        if(numEditingController.text.isEmpty){
          desc = "Enter value first";
        }else{
          var num = double.parse(numEditingController.text);

            if(selectTo == "MYR"){
                result = num * MYR;
                rate = "1 "+selectFrom+ " equals to "+ MYR.toString() +" "+selectTo;
                desc = "RM"+result.toStringAsFixed(2);
            }else if(selectTo == "GBP"){
               result = num * GBP;
               rate = "1 "+selectFrom+ " equals to "+ GBP.toString() +" "+selectTo;
               desc = "£"+result.toStringAsFixed(2);
            }else if(selectTo == "JPY"){
               result = num * JPY;
               rate = "1 "+selectFrom+ " equals to "+ JPY.toString() +" "+selectTo;
               desc = "JP¥"+result.toStringAsFixed(2);
            }else if(selectTo == "USD"){
               result = num * USD;
               rate = "1 "+selectFrom+ " equals to "+ USD.toString() +" "+selectTo;
               desc = "US\$" +result.toStringAsFixed(2);
            }else if(selectTo == "KRW"){
               result = num * KRW;
               rate = "1 "+selectFrom+ " equals to "+ KRW.toString() +" "+selectTo;
               desc = "₩"+result.toStringAsFixed(2);
            }else if(selectTo == "EUR"){
               result = num * EUR;
               rate = "1 "+selectFrom+ " equals to "+ EUR.toString() +" "+selectTo;
               desc = "€"+result.toStringAsFixed(2);
            }   
      }
      }else{
          print("Failed");
      }
      });
    }
}