import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internApp/usage_files/product_services.dart';
import 'package:internApp/usage_files/utility_services.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  ProductService _productService = ProductService();
  GlobalKey<FormState> _formsKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productsellerController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productsellcontController = TextEditingController();
  TextEditingController productBrandController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  File _image;
  bool isUploading;

  @override
  void initState() {
    super.initState();
    isUploading = false;
    //  _getCategories();
    //   _getBrands();
    //   print("------cat len======${categoryDropdown.length}");
    //   categoryDropdown = getCategoriesDropdown();
  }

//=================Category DropDown============================
/*   List<DropdownMenuItem<String>> getCategoriesDropdown() {
    //_getCategories();
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
          0,
          DropdownMenuItem(
            child: Text(categories[i].data['category']),
            value: categories[i].data['category'],
          ),
        );
      });
    }
    //print(items.length);
    return items;
  }
 */
//=================Brand  DropDown============================
/*   List<DropdownMenuItem<String>> getBrandsDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; ++i) {
      setState(() {
        items.insert(
          0,
          DropdownMenuItem(
            child: Text(brands[i].data['brand']),
            value: brands[i].data['brand'],
          ),
        );
      });
    }
    return items;
  } */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: true,
          title: Text('  Add Product  '),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                size: 35.0,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.amber[200],
                // Colors.amber[200],
                Colors.amber[300],
                Colors.amber[400],
                Colors.amber[400],
                Colors.amber[500],
                Colors.amber[600],
                Colors.amber[700],
              ],
            ),
          ),
          child: Form(
            key: _formsKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    shadowColor: Colors.yellow[600],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.blue[600],
                        height: 200.0,
                        width: 300.0,
                        child: OutlineButton(
                          child: _displayChild(),
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                          onPressed: () {
                            _selectImage(ImagePicker.pickImage(
                                source: ImageSource.gallery));
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 16.0),
                    child: Text(
                      "PRODUCT DETAILS",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),

                  //===================Product Name===========================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 4.0),
                    child: TextFormField(
                      maxLength: 30,
                      //keyboardType: TextInputType.
                      controller: productNameController,
                      decoration: InputDecoration(
                        hintText: "Product name",
                        labelText: "Enter product name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Product name cannot be empty";
                        } else if (value.length > 20) {
                          return "Character limit exceeded !!!";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  //==========================Category============================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 4.0),
                    child: TextFormField(
                      controller: productCategoryController,
                      decoration: InputDecoration(
                        hintText: "Product category",
                        labelText: "Enter product category",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Product category cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  //=========================Brand=====================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
                    child: TextFormField(
                      controller: productBrandController,
                      decoration: InputDecoration(
                        hintText: "Product brand",
                        labelText: "Enter product brand",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  //               //=================Price================================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
                    child: TextFormField(
                      controller: productPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rs. ",
                        hintText: "Product price",
                        labelText: "Enter product Price",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Product price cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  //================Seller=======================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
                    child: TextFormField(
                      controller: productsellerController,
                      decoration: InputDecoration(
                        hintText: "Seller's name",
                        labelText: "Enter seller's name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Seller's name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  //      //=======================contact========================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
                    child: TextFormField(
                      controller: productsellcontController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Seller's contact",
                        labelText: "Enter seller's contact",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Seller's contact cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  //               //===========Description===============================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
                    child: TextField(
                      controller: productDescriptionController,
                      maxLength: 100,
                      // expands: true,
                      maxLines: null,
                      minLines: null,
                      textAlign: TextAlign.start,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "Description",
                        labelText: "Enter product description",
                        border: OutlineInputBorder(),
                      ),
                      // onChanged:,
                    ),
                  ),

                  //==========================button==========================
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.red[400],
                      elevation: 10.0,
                      child: MaterialButton(
                        autofocus: true,
                        onPressed: () {
                          validateandUpload();
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Add Product",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*    _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    // print(data.length);
    setState(() {
      categories = data;
      // print(categories.length);
      categoryDropdown = getCategoriesDropdown();
      //print(categoryDropdown.length);
      currentCategory = categories[0].data["category"];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      brandDropdown = getBrandsDropdown();
      currentBrand = brands[0].data["brand"];
    });
  } 
  changeSelectedCategory(String selectedCategory) {
    setState(() => currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => currentBrand = selectedBrand);
  } 
 */

  void _selectImage(Future<File> pickImage) async {
    File temp = (await pickImage);
    setState(() {
      _image = temp;
    });
  }

  Widget _displayChild() {
    if (_image == null) {
      return Padding(
          padding: EdgeInsets.fromLTRB(14.0, 40.0, 14.0, 40.0),
          child: Icon(Icons.add));
    } else {
      return Image.file(
        _image,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
  }

  void validateandUpload() async {
    if (_formsKey.currentState.validate()) {
      if (_image != null) {
        String imageUrl;
        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task = storage.ref().child(picture).putFile(_image);

        task.onComplete.then((snapshot) async {
          imageUrl = await snapshot.ref.getDownloadURL();

          _productService.uploadProducts(
            productName: productNameController.text,
            category: productCategoryController.text,
            brand: productBrandController.text,
            image: imageUrl,
            seller: productsellerController.text,
            contact: productsellcontController.text,
            price: double.parse(productPriceController.text),
            description: productDescriptionController.text,
          );
          _brandService.createBrand(productBrandController.text);
          _categoryService.createCategory(productCategoryController.text);
          _formsKey.currentState.reset();

          Fluttertoast.showToast(msg: "Product added successfully");
          Navigator.pop(context);
        });
      } else {
        Fluttertoast.showToast(msg: "Image must be provided");
      }
    }
  }
}
