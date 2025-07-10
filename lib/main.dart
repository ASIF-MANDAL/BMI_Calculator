import 'package:bmi_app/resultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String selectedUnit = 'cm';
  var result = "";
  double? weightKg;

  double heightToCm(double value, String unit) {
    switch (unit) {
      case 'cm':
        return value;                // already cm
      case 'inch':
        return value * 2.54;         // 1 inch = 2.54 cm
      case 'ft':
        return value * 30.48;        // 1 foot = 30.48 cm
      default:
        throw ArgumentError('Unknown unit: $unit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE14434),
        title: Text("BMI APP",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      isMaleSelected = true;
                      isFemaleSelected = false;
                    });
                  },
                  child: Container(
                    width: 155.sp,
                    height: 180.sp,
                    decoration: BoxDecoration(
                      color: isMaleSelected ? Colors.blueAccent :  const Color(0xFF5EABD6),
                      borderRadius: BorderRadius.circular(12.sp), // curved corners
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.male,
                        size: 100.sp,
                        color: Colors.white,),
                        SizedBox(height: 10.sp,),
                        Text("MALE",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      isFemaleSelected = true;
                      isMaleSelected = false;
                    });
                  },
                  child: Container(
                    width: 155.sp,
                    height: 180.sp,
                    decoration: BoxDecoration(
                      color: isFemaleSelected ? Colors.pinkAccent : const Color(0xFFFFB4B4),
                      borderRadius: BorderRadius.circular(12.sp), // curved corners
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.female,
                        size: 100.sp,
                        color: Colors.white,),
                        SizedBox(height: 10.sp,),
                        Text("FEMALE",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.sp,),
            Container(
              margin: EdgeInsets.only(top: 24.sp),           // space above
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.sp),
                border: Border.all(color: Colors.grey.shade400),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.sp,
                    offset: Offset(0.sp, 2.sp),
                    color: Colors.black12,
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.height),
                  SizedBox(width: 6.sp,),
                  Expanded(
                    child: TextField(
                      controller: heightController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Height',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(width: 12.sp),

                  DropdownButton<String>(
                    value: selectedUnit,               // current choice
                    items: const [
                      DropdownMenuItem(value: 'cm',   child: Text('cm',)),
                      DropdownMenuItem(value: 'ft', child: Text('ft')),
                      DropdownMenuItem(value: 'inch', child: Text('inch')),
                    ],
                    onChanged: (String? value) {
                      if (value == null) return;
                      setState(() => selectedUnit = value); // trigger rebuild
                    },
                    underline: const SizedBox(),       // optional: hide underline
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.sp),                 // gap below height field
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.sp),
                border: Border.all(color: Colors.grey.shade400),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0.sp, 2.sp),
                    color: Colors.black12,
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.line_weight),
                  SizedBox(width: 6.sp,),
                  Expanded(
                    child: TextField(
                      controller: weightController,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Weight',
                        border: InputBorder.none,
                      ),
                      // onChanged: (v) => weightKg = double.tryParse(v), // optional
                    ),
                  ),

                  SizedBox(width: 12.sp),

                  // ---------- Static unit label ----------
                  Text(
                    '|',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8.sp),
                  Text(
                    'KG',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.sp,),
            ElevatedButton(onPressed: (){
              var height = heightController.text.toString();
              var weight = weightController.text.toString();

              if(height != "" && weight != "" && (isMaleSelected || isFemaleSelected)){
                //Calculation
                double rawHeight = double.parse(height);
                double weightKg  = double.parse(weight);

                var heightCm = heightToCm(rawHeight, selectedUnit);
                var heightM = heightCm / 100.0;

                var bmi = weightKg / (heightM * heightM);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultPage(
                      bmi: bmi,
                      heightCm: heightCm,
                      weightKg: weightKg,
                      gender: isMaleSelected ? 'Male' : 'Female',
                    ),
                  ),
                );


              } else {
                setState(() {
                  result = "Please fill all the Information!!";
                });
              }

            }, style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFE5D26),  // button fill
              foregroundColor: Colors.white,             // text & icon color

              padding: EdgeInsets.symmetric(
                horizontal: 40.sp,
                vertical: 16.sp,
              ),
              minimumSize: Size.fromHeight(56.sp),
              textStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2.sp,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.sp), // curved corners
              ),
              elevation: 4,               // subtle shadow
              shadowColor: Colors.black26, // softer shadow color
            ), child: const Text("Calculate")),
            Text(result, style: TextStyle(fontSize: 16.sp, color: Colors.redAccent),)
          ],
        ),
      ),
    );
  }
}
