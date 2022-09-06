import 'package:mealhub_group_test_project/blocs/details_bloc/details_bloc.dart';
import 'package:mealhub_group_test_project/blocs/details_bloc/details_event.dart';
import 'package:mealhub_group_test_project/blocs/details_bloc/details_state.dart';
import 'package:mealhub_group_test_project/middleware/models/user.dart';
import 'package:mealhub_group_test_project/middleware/repositories/api_repository_impl.dart';
import 'package:mealhub_group_test_project/shared/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late DetailsBloc _detailsBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _detailsBloc = DetailsBloc(ApiRepositoryImpl())..add(LoadUserEvent());
  }

  @override
  void dispose() {
    _detailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _detailsBloc,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(children: [
              NavigationWidget(title: 'User Details', child: _renderEditIcon()),
              Expanded(child: _render()),
            ])));
  }

  Widget _render() {
    return BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
      if (state is UserLoadedState) {
        return _renderDeatils(user: state.user);
      }

      if (state is UserNotLoadedState) {
        Navigator.pop(context);
      }

      return const Align(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      ));
    });
  }

  Widget _renderEditIcon() {
    return GestureDetector(
        onTap: _onEditTap,
        child: const Padding(
            padding: EdgeInsets.only(right: 20), child: Icon(Icons.edit)));
  }

  Widget _renderDeatils({required User user}) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _locationController.text = user.address.city + user.address.street;

    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(children: [
            const Text('Name: '),
            const SizedBox(
              width: 20,
            ),
            _renderName()
          ]),
          Row(children: [
            const Text('Email: '),
            const SizedBox(width: 20),
            _renderEmail()
          ]),
          Row(children: [
            const Text('Phone: '),
            const SizedBox(width: 20),
            _renderPhone()
          ]),
          Row(children: [
            const Text('Location: '),
            const SizedBox(width: 20),
            _renderLocation()
          ]),
        ]));
  }

  Widget _renderName() {
    return Expanded(
        child: TextFormField(
            controller: _nameController,
            readOnly: true,
            decoration: const InputDecoration(border: InputBorder.none)));
  }

  Widget _renderEmail() {
    return Expanded(
        child: TextFormField(
            controller: _emailController,
            readOnly: true,
            decoration: const InputDecoration(border: InputBorder.none)));
  }

  Widget _renderPhone() {
    return Expanded(
        child: TextFormField(
            controller: _phoneController,
            readOnly: true,
            decoration: const InputDecoration(border: InputBorder.none)));
  }

  Widget _renderLocation() {
    return Expanded(
        child: TextFormField(
            controller: _locationController,
            readOnly: true,
            decoration: const InputDecoration(border: InputBorder.none)));
  }

  void _onEditTap() {}
}
