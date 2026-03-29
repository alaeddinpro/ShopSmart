import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_admin/consts/app_constants.dart';
import 'package:shopsmart_admin/consts/validator.dart';
import 'package:shopsmart_admin/models/product_model.dart';
import 'package:shopsmart_admin/services/my_app_functions.dart';
import 'package:shopsmart_admin/widgets/subtitle_text.dart';
import 'package:shopsmart_admin/widgets/title_text.dart';

class EditUploadProductScreen extends StatefulWidget {
  const EditUploadProductScreen({super.key, this.productModel});
  static const routeName = '/EditUploadProductScreen';
  final ProductModel? productModel;
  @override
  State<EditUploadProductScreen> createState() =>
      _EditUploadProductScreenState();
}

class _EditUploadProductScreenState extends State<EditUploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _pickedImage;
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

  Future<void> _uploadProduct() async {
    if (_pickedImage == null && productNetworkImage == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    // _formKey.currentState!.save();
  }

  Future<void> _editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && productNetworkImage == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }
    if (!isValid) {
      return;
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
    return GestureDetector(
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
                  } else
                    await _uploadProduct();
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
    );
  }
}
