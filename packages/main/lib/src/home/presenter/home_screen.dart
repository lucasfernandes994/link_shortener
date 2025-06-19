import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:main/src/home/domain/entity/alias_entity.dart';
import 'package:main/src/ui/modal.dart';
import 'package:main/src/ui/ui_decoration.dart';
import 'package:main/src/ui/ui_kit_text_style.dart';
import 'package:main/src/ui/ui_sizes.dart';
import 'package:main/src/ui/widget_extensions.dart';

import 'home_controller.dart';
import 'home_state.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = GetIt.instance<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UiDecotation.background.dark(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Url shorten",
            style: UiKitTextStyle.style.large(
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: _Content(homeController: _homeController),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  _Content({required this.homeController});

  final HomeController homeController;
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return homeController.state.observer(
      builder: (context, state, _) {
        if (state is HomeErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showModal(
              context: context,
              title: 'Ops!',
              message: state.message,
              primaryButtonText: 'Ok',
              onPrimaryButtonTap: null,
              allowDismiss: true,
            );
          });
        }

        final List<Widget> items =
            state.alias.map((e) => _ListItem(aliasEntity: e)).toList();

        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(UiSizes.sm.value),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ChatInput(
                    controller: _controller,
                    formKey: _formKey,
                    onTap: () {
                      homeController.short(_controller.text);
                    },
                  ),
                  SizedBox(height: UiSizes.sm.value),
                  state is HomeLoadingState
                      ? CircularProgressIndicator(color: Colors.white)
                      : SizedBox.shrink(),
                  SizedBox(height: UiSizes.sm.value),
                  ...items,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final AliasEntity aliasEntity;

  const _ListItem({required this.aliasEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        borderOnForeground: true,
        elevation: UiSizes.xxs.value,
        shadowColor: Colors.black,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(UiSizes.xs.value)),
        ),
        child: Column(
          children: [
            Text(
              aliasEntity.alias,
              style: UiKitTextStyle.style.large(color: Colors.black),
            ).padding(padding: EdgeInsets.all(UiSizes.xs.value)),
          ],
        ),
      ).onTap(
        onTap: () {
          // TODO
        },
      ),
    );
  }
}

class ChatInput extends StatelessWidget {
  final TextEditingController controller;

  final GlobalKey<FormState> formKey;
  final Function onTap;

  ChatInput({
    super.key,
    required this.controller,
    required this.formKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          // Text Input
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Type a valid url',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Invalid url!";
                }
                return null;
              },
            ),
          ),
          SizedBox(width: UiSizes.xs.value),
          Container(
            decoration: const BoxDecoration(
              color: Colors.purple, // WhatsApp green
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.clear();
                  onTap();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
