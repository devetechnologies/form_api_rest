import 'package:flutter/material.dart';
import 'package:form_api_rest/input_decorations.dart';
import 'package:form_api_rest/product_image.dart';
import 'package:form_api_rest/services/http_services.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdmin extends StatefulWidget {
  @override
  State<ProductAdmin> createState() => _ProductAdminState();
}

class _ProductAdminState extends State<ProductAdmin> {
  String? pickedFilePath;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();
    HttpServices _httpServices = HttpServices();
    return Scaffold(
      backgroundColor: const Color(0XFFEEEEEE),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductImage(urlPath: pickedFilePath),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_new,
                            size: 40, color: Colors.white))),
                Positioned(
                    top: 60,
                    right: 25,
                    child: IconButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);

                          setState(() {
                            pickedFilePath = pickedFile!.path;
                          });
                        },
                        icon: const Icon(Icons.camera_alt_outlined,
                            size: 40, color: Colors.white)))
              ],
            ),
            _ProductForm(formKey: _formKey),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_outlined),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _httpServices
                .getResquest('/products-devetechnologies/products-products/');
          }
        },
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const _ProductForm({Key? key, required this.formKey}) : super(key: key);

  @override
  State<_ProductForm> createState() => __ProductFormState();
}

class __ProductFormState extends State<_ProductForm> {
  @override
  Widget build(BuildContext context) {
    var _formkey = widget.formKey;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: _buildBoxDecoration(),
        child: _createForm(_formkey),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);

  Widget _createForm(GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre Producto', labelText: 'Nombre'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nombre de campo Obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Descripción Producto', labelText: 'Descripción'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Descripción Obligatoria';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Precio Producto', labelText: 'Precio'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Precio Obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
