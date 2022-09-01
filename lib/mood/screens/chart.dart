import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:untitled/mood/helpers/mooddata.dart';
import 'package:untitled/mood/models/moodcard.dart';

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  List<CircleAvatar> colors = [
    CircleAvatar(backgroundColor: Colors.red),
    CircleAvatar(backgroundColor: Colors.black),
    CircleAvatar(backgroundColor: Colors.pink),
    CircleAvatar(backgroundColor: Colors.purple),
    CircleAvatar(backgroundColor: Colors.green),
    CircleAvatar(backgroundColor: Colors.blue)
  ];

  List<String> colornames = ['Red', 'Black', 'Pink', 'Purple', 'Green', 'Blue'];
  double a=0;
  double b=0;
  double c=0;
  double d=0;
  double e=0;
  double f=0;
  double g=0;
  double h=0;
  double i=0;
  double j=0;
  double k=0;
  double l=0;
  double m=0;
  double n=0;
  double o=0;
  double p=0;
  double q=0;
  double r=0;
  double s=0;

  Map<String, double> dataMap = Map();
  Map<String, double> dataMap2=Map();
  void initState() {
    super.initState();
    Provider.of<MoodCard>(context,listen: false).data.forEach((element) {
      if(element.moodno==1)
        a=a+1;
      else if(element.moodno==2)
        b=b+1;
      else if(element.moodno==3)
        c=c+1;
      else if(element.moodno==4)
        d=d+1;
      else if(element.moodno==5)
      e=e+1;
      else
       f=f+1;


    });
    
    Provider.of<MoodCard>(context,listen: false).actiname.forEach((element) {
      if(element=='Sports')
       g=g+1;
      else if(element=='Sleep')
       h=h+1;
       else if(element=='Shop')
       i=i+1;
       else if(element=='Relax')
       j=j+1;
       else if(element=='Read')
       k=k+1;
       else if(element=='Movies')
       l=l+1;
       else if(element=='Gaming')
       m=m+1;
       else if(element=='Friends')
       n=n+1;
       else if(element=='Family')
       o=o+1;
       else if(element=='Excercise')
       p=p+1;
       else if(element=='Eat')
       q=q+1;
       else if(element=='Date')
       r=r+1;
       else if(element=='Clean')
       s=s+1;
    });


    dataMap.putIfAbsent("Happy", () => b);
    dataMap.putIfAbsent("Sad", () => c);
    dataMap.putIfAbsent("Angry", () => a);
    dataMap.putIfAbsent("Surprised", () => d);
    dataMap.putIfAbsent("Scared", () => f);
    dataMap.putIfAbsent("Loving", () => e);
    dataMap2.putIfAbsent('Sports', () => g);
    dataMap2.putIfAbsent('Sleep', () => h);
    dataMap2.putIfAbsent('Shop', () => i);
    dataMap2.putIfAbsent('Relax', () => j);
    dataMap2.putIfAbsent('Read', () => k);
    dataMap2.putIfAbsent('Movies', () => l);
    dataMap2.putIfAbsent('Gaming', () => m);
    dataMap2.putIfAbsent('Friends', () => n);
    dataMap2.putIfAbsent('Family', () => o);
    dataMap2.putIfAbsent('Excercise', () => p);
    dataMap2.putIfAbsent('Eat', () => q);
    dataMap2.putIfAbsent('Date', () => r);
    dataMap2.putIfAbsent('Clean', () => s);
    
  }

  @override
  Widget build(BuildContext context) {
    List<MoodData> data = Provider.of<MoodCard>(context, listen: true).data;
    List<charts.Series<MoodData, String>> series = [
      charts.Series(
        id: 'Moods',
        data: data,
        domainFn: (MoodData series, _) => series.date,
        measureFn: (MoodData series, _) => series.moodno,
        colorFn: (MoodData series, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      )
    ];

    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
     
        
        title: Text('Mood Graph'), backgroundColor: Colors.lightGreen,
        
           actions: [
          SizedBox(width: 200,),
         IconButton(onPressed: (){
            Navigator.of(context).pushNamed('/start');
         }, icon: Icon(Icons.arrow_back))
        ],
        ),

      body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
        width:300,
        child: Card(
                    child: Row(
            children: <Widget>[
              SizedBox(width: 120),
              Column(
                children: <Widget>[
                  Text('1-',style: TextStyle(fontWeight:FontWeight.bold),),
                  Text('2-',style: TextStyle(fontWeight:FontWeight.bold),),
                  Text('3-',style: TextStyle(fontWeight:FontWeight.bold),),
                  Text('4-',style: TextStyle(fontWeight:FontWeight.bold),),
                  Text('5-',style: TextStyle(fontWeight:FontWeight.bold),),
                  Text('6-',style: TextStyle(fontWeight:FontWeight.bold),)
                ],
              ),
              SizedBox(width:20),
              Column(children: <Widget>[
                Text('Angry',style: TextStyle(fontWeight:FontWeight.bold),),
                Text('Happy',style: TextStyle(fontWeight:FontWeight.bold),),
                Text('Sad',style: TextStyle(fontWeight:FontWeight.bold),),
                Text('Surprised',style: TextStyle(fontWeight:FontWeight.bold),),
                Text('Loving',style: TextStyle(fontWeight:FontWeight.bold),),
                Text('Scared',style: TextStyle(fontWeight:FontWeight.bold),)
              ])
            ],
          ),
        ),
              ),
           
              PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width / 2.7,
                              chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                ),

              legendOptions: LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          
      
              chartType: ChartType.disc,
            ),

            Container(
              height: 330,
              width: 400,
              
              child: PieChart(
                dataMap: dataMap2,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery.of(context).size.width / 2.7,
                          chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                ),
                
                     legendOptions: LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          
                chartType: ChartType.disc,
              ),
            ),

               Center(
        child: Container(
          height: 200,
          width: 300,
          child: charts.BarChart(
            series,
            animate: true,
          ),
        ),
              ),
            ],
          ),
      ),
    );
  }
}