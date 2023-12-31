import 'package:TheMerchPerch/services/add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddProductUi extends StatefulWidget {
  AddProductUi({Key? key}) : super(key: key);

  @override
  State<AddProductUi> createState() => _AddProductUiState();
}

dynamic image;

class _AddProductUiState extends State<AddProductUi> {
  // late File _image;
  late File _image;
  dynamic netImage;
  bool apiCallProcess = false;
  final ImagePicker selectedimage = ImagePicker();
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController availableVehicle = TextEditingController();
  TextEditingController price = TextEditingController();

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }

  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  String dropdownvalue = "Goldfish";

  var items = [
    'Goldfish',
    'Oscar',
    'Tetra',
    'Molly',
    'European anchovy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.redAccent[700],
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/icons/shopping.png',
                            color: Colors.greenAccent[700],
                          ),
                        ),
                        // Icon(
                        //   Icons.TheMerchPerch_outlined,
                        //   size: 60,
                        //   color: Colors.green[700],
                        // ),
                      ],
                    ),
                    _gap(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please provide Product name";
                        } else {
                          null;
                        }
                      },
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "Product Name",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.production_quantity_limits,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    // _gap(),
                    // TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   // onSaved: (input) => email = input,
                    //   validator: (input) {
                    //     if (input == null || input.isEmpty) {
                    //       return "Empty Brand Name";
                    //     } else {
                    //       null;
                    //     }
                    //   },
                    //   controller: brand,
                    //   decoration: InputDecoration(
                    //     labelText: "Car Brand",
                    //     hintStyle: TextStyle(color: Colors.grey),
                    //     border: OutlineInputBorder(),
                    //     prefixIcon: Icon(
                    //       Icons.branding_watermark_outlined,
                    // color: Colors.green[900],
                    // size: 25,
                    //     ),
                    //   ),
                    // ),
                    _gap(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3)),
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.category_outlined,
                            size: 30,
                            color: Colors.green[900],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green[50],
                                border:
                                    Border.all(color: Colors.green.shade900),
                                borderRadius: BorderRadius.circular(3)),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton(
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                  print(dropdownvalue);
                                });
                              },
                              iconSize: 32,
                              underline: const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // _gap(),
                    // TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   // onSaved: (input) => email = input,
                    //   validator: (input) {
                    //     if (input == null || input.isEmpty) {
                    //       return "Empty Category";
                    //     } else {
                    //       null;
                    //     }
                    //   },
                    //   controller: category,
                    //   decoration: InputDecoration(
                    //     labelText: "Category",
                    //     hintStyle: const TextStyle(color: Colors.grey),
                    //     border: const OutlineInputBorder(),
                    //     prefixIcon: Icon(
                    //       Icons.category_outlined,
                    //       color: Colors.green[900],
                    //       size: 30,
                    //     ),
                    //   ),
                    // ),
                    _gap(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Empty Description";
                        } else {
                          null;
                        }
                      },
                      controller: description,
                      decoration: InputDecoration(
                        labelText: "Description",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.description_outlined,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please enter available Product";
                        } else {
                          null;
                        }
                      },
                      controller: availableVehicle,
                      decoration: InputDecoration(
                        labelText: "Number of Product Avaliable",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.touch_app_outlined,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      // onSaved: (input) => email = input,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please Provide Price";
                        } else {
                          null;
                        }
                      },
                      // onSaved: (input) => _value = num.tryParse(input),
                      controller: price,
                      decoration: InputDecoration(
                        labelText: "Price",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.green[900],
                          size: 30,
                        ),
                      ),
                    ),
                    _gap(),
                    image != null
                        ? Image.file(
                            image!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                  Icons.photo_library,
                                  size: 40,
                                  color: Colors.green[900],
                                ),
                                const Text(
                                  'Select Photos',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[200],
                              // shape: const StadiumBorder(),
                              // fixedSize:
                              //     const Size(double.maxFinite, double.infinity),
                              textStyle: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[900],
                          shape: const StadiumBorder(),
                          fixedSize:
                              const Size(double.maxFinite, double.infinity),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (apiCallProcess == false) {
                            if (validateAndSave()) {
                              setState(() {
                                apiCallProcess = true;
                              });
                            }
                            postproduct(
                              name.text,
                              dropdownvalue.toString(),
                              description.text,
                              availableVehicle.text,
                              price.text,
                              image ?? null,
                              context,
                            ).then((value) => {
                                  setState(() {
                                    apiCallProcess = false;
                                  }),
                                  Navigator.pop(context),
                                  Fluttertoast.showToast(
                                    msg:
                                        "Congratulations ! \n Product has been added",
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 20.0,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.green[800],
                                  ),
                                });
                          }
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                      ),
                    ),
                    _gap(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
