import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class Abouthero extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final List abilities = args['abilities'];
    args['category']==null?args['category']="":args['category']=args['category'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color:Colors.black,
        ),
        backgroundColor: Colors.amber[50],
      ),
      body: Container(
        color: Colors.amber[50],
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
           
              slivers: <Widget>[
                SliverToBoxAdapter
                (
                   child: Center(
                         child: Padding(

                                      padding: EdgeInsets.only(top: 20.0,bottom:20.0),                                                                                                        child: Hero(
                               tag: args['name']+args['imageurl'],
                                      child: CachedNetworkImage(
                          imageUrl: args['imageurl'],
                          imageBuilder: (context,imageProvider)=>Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image : DecorationImage(
                                image: imageProvider,
                              fit: BoxFit.cover)
                            ),
                            ),
                          placeholder: (context,url) => CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[800]),

                          ),
                          errorWidget: (context,url,error)=>Icon(
                            Icons.error
                          ),

                        ),
                      ),
                                                                      ),
                                  ),
                ),
                   SliverToBoxAdapter(
                                            child: SizedBox(
                           height : 10.0
                              ),
                     ),
                      SliverToBoxAdapter(
                          child: Center(
                           child: Text(args['name'],
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 30.0
                        ),),
                                              ),
                      ),
                      SliverToBoxAdapter(
                          child: Center(
                           child: Text(args['category'],
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0
                        ),),
                                              ),
                          
                      ),
                 
                      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                            return Card( 
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                              
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                           
                            margin: EdgeInsets.symmetric(vertical:15.0,horizontal:10.0) ,
                              child: Container(
                                        decoration: BoxDecoration(
                                    color: Colors.amber[100],
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [BoxShadow(
                                  color:Colors.yellow[900].withOpacity(0.5),
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(0,10),
              
                                      ),],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Widgets(name: abilities[index]['ability_name'],type: abilities[index]['ability_type'],desc: abilities[index]['ability_desc']),
                                ),
                              ));
                      },
                      childCount: abilities.length,
                      
                      ),
                     
                  
                    ),
            
              ],
            ),
          
        
      
    ));
  }
}


class Widgets extends StatelessWidget {
  final String name;
  final String type;
  final String desc;

  const Widgets({Key key, this.name, this.type, this.desc}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Center(
                  child: Text(name,
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 20.0,
            color: Colors.deepPurple[900]
          ),
          ),
        ),
       SizedBox(
         height: 10.0,
       ),
       SizedBox(
         
         child: Text(
            type,
            style: TextStyle(
            fontFamily: 'Varela',
            color: Colors.deepPurple[800]
            ),
         ),
       ), 
       SizedBox(
         height: 10.0,
       ),
       Card(
         color: Colors.blue[50],
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          
         ),
         child: Column(
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(14.0),
               child: Text(desc,
               style: TextStyle(
                 fontFamily: 'Varela',
                 color: Colors.blue,
                 fontWeight: FontWeight.bold
                ),
               ),
             )
           ],
         ),
       ),
      ],
      ),
    
    );
  }
}