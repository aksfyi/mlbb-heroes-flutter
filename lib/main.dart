import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'abouthero.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context)=> MyApp(),
    '/hero':(context) => Abouthero()
  },
  debugShowCheckedModeBanner: false,
 
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List datalist;
    doit() async{
      
    Response response= await get("https://aktsrcs.github.io/mlbb-unofficial-api/data2.json");
    Map results = jsonDecode(response.body);
    setState(() {
      datalist = results['results'];
    });
    
  }

 @override
  void initState() {
    doit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('MLBB Heroes',
        style:TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          fontFamily: 'Varela',
          color: Colors.black
        ),
        ),
        backgroundColor: Colors.amber[50],
  
      ),
      body:Container(
        color: Colors.amber[50],
        child:datalist!=null?Maincont(datalist: datalist,):Container(
          
          child: Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow[600]),
          ))), ),
      

    );
  }
}

class Maincont extends StatelessWidget {
  final List datalist;

  const Maincont({Key key, this.datalist}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:0,bottom:0.0),
          
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                child: CustomScrollView(
        
    physics: BouncingScrollPhysics(),
    slivers: <Widget>[SliverToBoxAdapter(
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10,
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(10.0)),
            image:DecorationImage(
                
                image:AssetImage('lib/assets/mlbb_logo.png'),
                fit: BoxFit.cover 
                
                ),
            ),
          ),
        ),
      ),
    ),
      SliverGrid(
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.25,
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        ),
        
       delegate: SliverChildBuilderDelegate((BuildContext context,int index){
         
         
         
         return Padding(
           padding: const EdgeInsets.all(10.0),
           child: Heroes(heroname: datalist[index]['hero_name'],herodata: datalist[index]['abilities'],imageurl:"https://aktsrcs.github.io/mlbb-unofficial-api/thumbs/"+datalist[index]['hero_name'].replaceAll(" ","_")+".png",category: datalist[index]['stats']['category'], ),
         );
       },
       childCount: datalist.length),
      ),
    ],),
            )
        );
  
  }
}
class Heroes extends StatelessWidget {
  final String imageurl;
  final String heroname;
  final List herodata;
  final String category;

  const Heroes({Key key, this.imageurl, this.heroname, this.herodata,this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: InkWell(
            onTap:()  {Navigator.pushNamed(context, '/hero',arguments: {
      'name' : heroname,
      'imageurl':imageurl,
      'abilities': herodata,
      'category': category

            });},
            child: Card(
              elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
     
      child: Container(
        decoration: BoxDecoration(
                color: Colors.amber[100],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
           boxShadow: [BoxShadow(
              color:Colors.yellow[900].withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(0,10)
              
              ),],
        ),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          
            Center(
              child: Hero(
            tag: heroname+imageurl,
            child: CachedNetworkImage(
          imageUrl: imageurl,
          imageBuilder: (context,imageProvider)=>Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
             
              shape: BoxShape.circle,
              image : DecorationImage(
        image: imageProvider,
              fit: BoxFit.cover)
            ),
            ),
          placeholder: (context,url) => CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[900]),

          ),
          errorWidget: (context,url,error)=>Icon(
            Icons.error
          ),

        ),
              ),
              
            ),
            SizedBox(height: 10,),
            Center(
              child:Text(heroname,
              style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        fontFamily: 'Varela',
        color: Colors.black,
              ),
              ),
            ),
          ],),
      ),
      ),
            )

      
    );
  }
}