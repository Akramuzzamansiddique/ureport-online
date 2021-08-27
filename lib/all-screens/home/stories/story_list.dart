import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ureport_ecaro/all-screens/home/stories/stories-details.dart';
import 'package:ureport_ecaro/all-screens/home/stories/story-controller.dart';
import 'package:provider/provider.dart';
import 'package:ureport_ecaro/utils/nav_utils.dart';
import 'package:ureport_ecaro/utils/resources.dart';
import 'package:ureport_ecaro/widgets/CNetworkImage.dart';
import 'model/response-story-data.dart' as storyarray;

import 'model/response-story-data.dart';

class StoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Provider.of<StoryController>(context,listen: false).addPageListener();

    return Consumer<StoryController>(builder: (context, provider, snapshot) {
      return SafeArea(
          child: Scaffold(
              body: provider.isloading? Center(child: CircularProgressIndicator(),):Stack(
                children: [
                  getBackground(),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                          margin: EdgeInsets.only(top: 10),
                          child: Image(
                              fit: BoxFit.fill,
                              height: 35,
                              width: 140,
                              image: AssetImage('assets/images/ureport_logo.png')),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          margin: EdgeInsets.only(top: 20, bottom: 15),
                          child: Text(
                            "Stories",
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.black,
                                fontFamily: 'Dosis'
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Divider(
                            height: 1.5,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                          child:PagedListView<int, storyarray.Result>.separated(
                            padding: EdgeInsets.only(top: 0),
                            pagingController: provider.pagingController,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 0,
                                color: MyColors.lightestGrayDE(context),
                              );
                            },
                            builderDelegate: PagedChildBuilderDelegate<storyarray.Result>(
                              itemBuilder: (context, item, index) {
                                return GestureDetector(
                                  onTap: (){
                                    NavUtils.push(context, StoryDetails(item.content));
                                  },
                                  child: Container(
                                    child: getItem(
                                        item.images.length>0? item.images[0]:"assets/images/default.jpg",
                                        item.createdOn.toString(),
                                        item.title,
                                        item.summary),
                                  ),
                                );
                              },
                            ),
                          ),
                        )


                       /* ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:  provider.responseStoriesData?.results.length??0,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  NavUtils.push(context, StoryDetails(provider.responseStoriesData!.results[index].content));
                                },
                                child: Container(
                                  child: getItem(
                                      provider.responseStoriesData!.results[index].images.length>0?provider.responseStoriesData!.results[index].images[0]:"assets/images/default.jpg",
                                      provider.responseStoriesData!.results[index].createdOn.toString(),
                                      provider.responseStoriesData!.results[index].title,
                                      provider.responseStoriesData!.results[index].summary),
                                ),
                              );
                            }),*/

                      ],

                    ),
                  )
                ],
              ))

      );
    });
  }
}

getBackground() {
  return Image(image: AssetImage("assets/images/bg_home.png"));
}





getItem(String image_url, String date, String title, String summery) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.only(top: 10, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getItemTitleImage(image_url),
        getItemDate(date),
        getItemTitle(title),
        getItemSummery(summery),
      ],
    ),
  );
}

getItemTitleImage(String image_url) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    child: CNetworkImage(height: 150,url: image_url,fit: BoxFit.cover,
      placeholderWidget: Image.asset("assets/images/default.jpg"),
      errorWidget: Image.asset("assets/images/default.jpg"),


    ),

    /*FadeInImage(image: NetworkImage(image_url),
        placeholder: AssetImage("assets/images/default.jpg"),
    height: 150,),*/
    /*Image.network(
      image_url,
      height: 150.0,
      fit: BoxFit.cover,

    )*/
  );
}

getItemDate(String date) {
  return Container(
    padding: EdgeInsets.only(top: 10, left: 10),
    child: Text(
      date,
      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
    ),
  );
}

getItemTitle(String title) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}

getItemSummery(String summery) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
    child: Text(
      summery,
      style: TextStyle(fontSize: 14),
    ),
  );
}
