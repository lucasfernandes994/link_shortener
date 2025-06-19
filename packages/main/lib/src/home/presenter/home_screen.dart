import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main/src/detail/detail_screen.dart';
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
  final HomeController homeController;

  const HomeScreen({Key? key, required this.homeController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(homeController);
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController;

  _HomeScreenState(this.homeController);

  @override
  void initState() {
    super.initState();
    homeController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UiDecotation.background.dark(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: UiSizes.lg.value,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          title: Text(
            "Link shortener",
            style: UiKitTextStyle.style.large(color: Colors.white),
          ),
        ),
        body: _Content(homeController: homeController),
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
            state.aliases
                .map(
                  (e) =>
                      _ListItem(aliasEntity: e, homeController: homeController),
                )
                .toList();

        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(
              left: UiSizes.sm.value,
              right: UiSizes.sm.value,
              top: UiSizes.lg.value,
            ),
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
                  SizedBox(height: UiSizes.lg.value),
                  Text(
                    "Recently shortened links",
                    style: UiKitTextStyle.style.small(color: Colors.white),
                  ),
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
  final HomeController homeController;

  const _ListItem({required this.aliasEntity, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: UiSizes.xxs.value,
      shadowColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(UiSizes.xs.value)),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 123, 5, 145), Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  aliasEntity.alias,
                  style: UiKitTextStyle.style.large(color: Colors.white),
                ).padding(
                  padding: EdgeInsets.only(
                    top: UiSizes.sm.value,
                    left: UiSizes.sm.value,
                  ),
                ),
                Text(
                  aliasEntity.links.short,
                  style: UiKitTextStyle.style.small(color: Colors.white),
                ).padding(
                  padding: EdgeInsets.only(
                    top: UiSizes.xs.value,
                    bottom: UiSizes.sm.value,
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                homeController.remove(aliasEntity);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
                size: UiSizes.sm.value * 2,
              ),
            ),
          ],
        ),
      ),
    ).onTap(
      onTap: () {
        context.go(DetailScreen.getRoute(aliasEntity.alias).toString());
      },
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
                  onTap();
                  controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
