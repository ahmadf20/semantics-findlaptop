import 'package:findlaptop/pages/about_us_page.dart';
import 'package:findlaptop/services/services.dart';
import 'package:findlaptop/utils/asset_manager.dart';
import 'package:findlaptop/utils/custom_bot_toast.dart';
import 'package:findlaptop/utils/loading_indicator.dart';
import 'package:findlaptop/utils/utils.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFilterShown = false;
  bool isLoading = false;

  List<String> brands = ['None'];
  List<String> types = ['None'];
  List<String> screenSizes = ['None'];
  List<String> rams = ['None'];

  String? selectedBrand = 'None';
  String? selectedType = 'None';
  String? selectedScreenSize = 'None';
  String? selectedRAM = 'None';

  List<Laptop> laptops = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController minPriceTC = TextEditingController();
  TextEditingController maxPriceTC = TextEditingController();

  void fetchProduct() async {
    isLoading = true;
    setState(() {});

    if (isFilterShown) {
      try {
        await NetworkServices.getByProducts(
          product: searchController.text,
          company: selectedBrand == 'None' ? null : selectedBrand,
          type: selectedType == 'None' ? null : selectedType,
          inches: selectedScreenSize == 'None' ? null : selectedScreenSize,
          ram: selectedRAM == 'None' ? null : selectedRAM,
          low: double.tryParse(minPriceTC.text),
          high: double.tryParse(maxPriceTC.text),
        ).then((res) {
          if (res is List<Laptop>) {
            laptops = res;
            setState(() {});
          } else {
            customBotToastText(res);
          }
        });
      } catch (e) {
        customBotToastText(ErrorMessage.general);
      } finally {
        isLoading = false;
        setState(() {});
      }
    } else {
      try {
        await NetworkServices.getByQuery(
          query: searchController.text,
        ).then((res) {
          if (res is List<Laptop>) {
            laptops = res;
            setState(() {});
          } else {
            customBotToastText(res);
          }
        });
      } catch (e) {
        customBotToastText(ErrorMessage.general);
      } finally {
        isLoading = false;
        setState(() {});
      }
    }
  }

  void fetchBrand() async {
    try {
      await NetworkServices.getBrand().then((res) {
        if (res is List<String>) {
          brands.addAll(res);
          setState(() {});
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    }
  }

  void fetchInches() async {
    try {
      await NetworkServices.getInches().then((res) {
        if (res is List<String>) {
          screenSizes.addAll(res);
          setState(() {});
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    }
  }

  void fetchRam() async {
    try {
      await NetworkServices.getRam().then((res) {
        if (res is List<String>) {
          rams.addAll(res);
          setState(() {});
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    }
  }

  void fetchType() async {
    try {
      await NetworkServices.getType().then((res) {
        if (res is List<String>) {
          types.addAll(res);
          setState(() {});
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
    fetchBrand();
    fetchInches();
    fetchRam();
    fetchType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.blue[900],
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FIND',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.blueAccent[100],
                          ),
                        ),
                        Text(
                          'LAPTOP',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        shadowColor: Colors.red,
                      ),
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blue[100],
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => AboutUsPage()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withAlpha(25),
                        blurRadius: 50,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (_) {
                      fetchProduct();
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari nama produk...',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(25, 22.5, 25, 22.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  constraints: BoxConstraints(maxWidth: 800),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          Container(
            color: Colors.blue[50],
            padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   'Tidak tau nama produknya?',
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
                // SizedBox(height: 10),
                TextButton(
                  child: Text(
                    isFilterShown ? 'CLEAR FILTER' : 'FILTER',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (isFilterShown) {
                      selectedBrand = 'None';
                      selectedType = 'None';
                      selectedScreenSize = 'None';
                      selectedRAM = 'None';
                      minPriceTC.clear();
                      maxPriceTC.clear();
                      fetchProduct();
                    }
                    isFilterShown = !isFilterShown;
                    setState(() {});
                  },
                ),
                if (isFilterShown) ...[
                  SizedBox(height: 35),
                  Container(
                    constraints: BoxConstraints(maxWidth: 800),
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: types.map((v) {
                        bool isSelected = v == selectedType;
                        return OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            backgroundColor:
                                isSelected ? Colors.blue : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: isSelected ? Colors.blue : Colors.red,
                              ),
                            ),
                          ),
                          child: Text(
                            v,
                            style: TextStyle(
                              color:
                                  isSelected ? Colors.white : Colors.grey[800],
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            selectedType = v;
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brand',
                            style: TextStyle(
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton(
                              underline: Container(),
                              elevation: 1,
                              onChanged: (String? val) {
                                selectedBrand = val;
                                setState(() {});
                              },
                              value: selectedBrand,
                              items: brands.map(
                                (v) {
                                  return DropdownMenuItem(
                                    child: Text(v),
                                    value: v,
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Screen Size',
                            style: TextStyle(
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton(
                              underline: Container(),
                              elevation: 1,
                              onChanged: (String? val) {
                                selectedScreenSize = val;
                                setState(() {});
                              },
                              value: selectedScreenSize,
                              items: screenSizes.map(
                                (v) {
                                  return DropdownMenuItem(
                                    child: Text(v),
                                    value: v,
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Memory',
                            style: TextStyle(
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton(
                              underline: Container(),
                              elevation: 1,
                              onChanged: (String? val) {
                                selectedRAM = val;
                                setState(() {});
                              },
                              value: selectedRAM,
                              items: rams.map(
                                (v) {
                                  return DropdownMenuItem(
                                    child: Text(v),
                                    value: v,
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Min Price',
                            style: TextStyle(
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 150,
                            child: TextField(
                              controller: minPriceTC,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(color: Colors.grey),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blue[200]!,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max Price',
                            style: TextStyle(
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 150,
                            child: TextField(
                              controller: maxPriceTC,
                              decoration: InputDecoration(
                                hintText: '1.000.000.000',
                                hintStyle: TextStyle(color: Colors.grey),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blue[200]!,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(22.5),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.red,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Filter Pencarian',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      fetchProduct();
                    },
                  ),
                  SizedBox(height: 25),
                ],
              ],
            ),
          ),
          SizedBox(height: 25),
          isLoading
              ? Center(
                  child: loadingIndicator(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 800),
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'Menampilkan ${laptops.length} data laptop',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
          if (!isLoading)
            Container(
              child: ListView.builder(
                padding: EdgeInsets.all(25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: laptops.length,
                itemBuilder: (context, index) {
                  Laptop item = laptops[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 800,
                              minWidth: 100,
                            ),
                            padding: EdgeInsets.all(25),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(
                                        AssetManager.getBrandIcon(
                                            item.company!),
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.product!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                item.typeName!,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '${item.ram!} • ${item.cpu!} • ${item.gpu!} • ${item.inches!}" • ${item.memory!} • ${item.opSys!} • ${item.screenResolution!} • ${item.weight!}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(children: [
                                  Spacer(),
                                  Text(
                                    'Rp ${formatNumber(item.price!)}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
