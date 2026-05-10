import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_admin/consts/app_constants.dart';
import 'package:shopsmart_admin/consts/validator.dart';
import 'package:shopsmart_admin/models/product_model.dart';
import 'package:shopsmart_admin/screens/loading%20manager.dart';
import 'package:shopsmart_admin/services/my_app_functions.dart';
import 'package:shopsmart_admin/widgets/subtitle_text.dart';
import 'package:shopsmart_admin/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

class EditUploadProductScreen extends StatefulWidget {
  const EditUploadProductScreen({super.key, this.productModel});
  static const routeName = '/EditUploadProductScreen';
  final ProductsModel? productModel;
  @override
  State<EditUploadProductScreen> createState() =>
      _EditUploadProductScreenState();
}

class _EditUploadProductScreenState extends State<EditUploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _pickedImage;
  bool isloading = false;
  late TextEditingController _titleController,
      _priceController,
      _descController,
      _quantityController;
  String? categoryValue;
  bool isEditing = false;
  String? productNetworkImage;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.productModel != null) {
      isEditing = true;
      productNetworkImage = widget.productModel!.productImage;
      categoryValue = widget.productModel!.productCategory;
    }
    super.initState();
    _titleController = TextEditingController(
      text: widget.productModel?.productTitle,
    );
    _priceController = TextEditingController(
      text: widget.productModel?.productPrice,
    );
    _descController = TextEditingController(
      text: widget.productModel?.productDescription,
    );
    _quantityController = TextEditingController(
      text: widget.productModel?.productQuantity,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _quantityController.dispose();
  }

  void clearForm() {
    _titleController.clear();
    _priceController.clear();
    _descController.clear();
    _quantityController.clear();
    removePickedImage();
  }

  void removePickedImage() {
    setState(() {
      _pickedImage = null;
      productNetworkImage = null;
    });
  }

  Future<String> uploadImage() async {
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/dxwo4sw4i/image/upload",
    );
    final request = http.MultipartRequest("POST", url)
      ..fields["upload_preset"] = "upload_images"
      ..files.add(
        await http.MultipartFile.fromPath("file", _pickedImage!.path),
      );
    final response = await request.send();
    print("STATUS CODE: ${response.statusCode}");
    print("IMAGE PATH: ${_pickedImage!.path}");
    if (response.statusCode != 200) {
      throw Exception("فشل رفع الصورة");
    }
    final responeData = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(responeData);
    return jsonResponse['secure_url'];
  }

  Future<void> _uploadProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please pick an image",
        fct: () {},
      );
      return;
    }
    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });
        final productid = Uuid().v4();
        await FirebaseFirestore.instance
            .collection("products")
            .doc(productid)
            .set({
              "productId": productid,
              "productTitle": _titleController.text.trim(),
              "productPrice": _priceController.text.trim(),
              "productDescription": _descController.text.trim(),
              "productQuantity": _quantityController.text.trim(),
              "productCategory": categoryValue,
              "productImage": await uploadImage(),
              "createdAt": Timestamp.now(),
            });
        Fluttertoast.showToast(
          msg: "Product has been uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (!mounted) {
          return;
        }
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: "ClearForm",
          fct: () {
            clearForm();
          },
        );
      } on FirebaseException catch (e) {
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,

          fct: () {},
          subtitle: e.message.toString(),
        );
      } catch (e) {
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: e.toString(),
          fct: () {},
        );
      } finally {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  Future<void> _editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    // if (_pickedImage == null) {
    //   MyAppFunctions.showErrorOrWarningDialog(
    //     context: context,
    //     subtitle: "Please pick an image",
    //     fct: () {},
    //   );
    //   return;
    // }
    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });

        final productid = widget.productModel!.productId;
        await FirebaseFirestore.instance
            .collection("products")
            .doc(productid)
            .update({
              "productId": productid,
              "productTitle": _titleController.text.trim(),
              "productPrice": _priceController.text.trim(),
              "productDescription": _descController.text.trim(),
              "productQuantity": _quantityController.text.trim(),
              "productCategory": categoryValue,
              "productImage": _pickedImage == null
                  ? widget.productModel!.productImage
                  : await uploadImage(),
              "createdAt": widget.productModel!.createdAt,
            });
        Fluttertoast.showToast(
          msg: "Product has been editing successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // if (!mounted) {
        //   return;
        // }
        // MyAppFunctions.showErrorOrWarningDialog(
        //   context: context,
        //   subtitle: "ClearForm",
        //   fct: () {
        //     clearForm();
        //   },
        // );
        // } on FirebaseException catch (e) {
        //   MyAppFunctions.showErrorOrWarningDialog(
        //     context: context,

        //     fct: () {},
        //     subtitle: e.message.toString(),
        //   );
        // } catch (e) {
        //   MyAppFunctions.showErrorOrWarningDialog(
        //     context: context,
        //     subtitle: e.toString(),
        //     fct: () {},
        //   );
      } finally {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && productNetworkImage == null) {
      MyAppFunctions.imagePickerDialog(
        context: context,
        cameraFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.camera);

          setState(() {});
        },
        galleryFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFCT: () async {
          setState(() {
            _pickedImage = null;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LoadingManager(
      isLoading: isloading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          bottomSheet: SizedBox(
            height: kBottomNavigationBarHeight + 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    clearForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  label: Text("Clear", style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.clear, color: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (isEditing) {
                      _editProduct();
                    } else {
                      await _uploadProduct();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  label: Text(
                    isEditing ? "Edit Product" : "Upload Product",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    isEditing ? Icons.edit : Icons.upload,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: TitlesTextWidget(
              label: isEditing ? "Edit Product" : "Upload a new Product",
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  if (isEditing && productNetworkImage != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        productNetworkImage!,
                        height: size.width * 0.5,
                        alignment: Alignment.center,
                      ),
                    ),
                  ] else if (_pickedImage == null) ...[
                    SizedBox(
                      width: size.width * 0.4 + 10,
                      height: size.width * 0.4,
                      child: DottedBorder(
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 80,
                                color: Colors.blueAccent,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    localImagePicker();
                                  });
                                },
                                child: Text("Upload Image"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(_pickedImage!.path),
                        height: size.width * 0.5,

                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                  if (_pickedImage != null || productNetworkImage != null) ...[
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            removePickedImage();
                          },
                          child: Text("Remove Image"),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 20),
                  DropdownButton(
                    items: AppConstants.categoriesDropList,
                    value: categoryValue,
                    hint: Text("Select a category"),
                    onChanged: (String? value) {
                      setState(() {
                        categoryValue = value;
                      });
                    },
                  ),
                  SizedBox(height: 26),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 00),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            key: const ValueKey("Title"),
                            maxLength: 80,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString:
                                    "Please enter a product title",
                              );
                            },
                            decoration: InputDecoration(
                              hintText: "Product Title",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: _priceController,
                                  key: const ValueKey("Price \$"),

                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^(\d+)?\.?\d{0,2}'),
                                    ),
                                  ],
                                  validator: (value) {
                                    return MyValidators.uploadProdTexts(
                                      value: value,
                                      toBeReturnedString: "Price is missing",
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Price",
                                    prefix: SubtitleTextWidget(
                                      label: "\$ ",
                                      fontSize: 16,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: TextFormField(
                                  controller: _quantityController,
                                  key: const ValueKey("Quantity"),

                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) {
                                    return MyValidators.uploadProdTexts(
                                      value: value,
                                      toBeReturnedString: "Quantity is missing",
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Quantity",
                                    prefix: SubtitleTextWidget(
                                      label: "Qty: ",
                                      fontSize: 16,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _descController,
                            key: const ValueKey("Description"),
                            maxLines: 7,
                            maxLength: 1000,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return MyValidators.uploadProdTexts(
                                value: value,
                                toBeReturnedString: "Description is missing",
                              );
                            },
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
