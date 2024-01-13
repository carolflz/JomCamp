import 'package:application/Screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:application/ressuable_widget/items_widget.dart';
import 'package:provider/provider.dart';
import 'package:application/api/cart_provider.dart';


class RentalScreen extends StatefulWidget {
  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection(){
    if(_tabController.indexIsChanging){
        setState(() {    
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Rental Catalogue',
            style: TextStyle(
              fontSize: 25.0,
              letterSpacing: 2.0,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.yellow.shade900,
            unselectedLabelColor: Colors.black,
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.yellow.shade900,
              ),
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(text: "Tent"),
              Tab(text: "Sleeping Bag"),
              Tab(text: "Clothing"),
              Tab(text: "Cooking Utensil"),
            ],
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cartProvider.cartCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ItemsWidget(category: 'Tent'),
                    ItemsWidget(category: 'Sleeping Bag'),
                    ItemsWidget(category: 'Clothing'),
                    ItemsWidget(category: 'Cooking Utensil'),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      );
  }
}