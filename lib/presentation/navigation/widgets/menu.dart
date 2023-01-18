import 'package:collaction_cms/application/navigation/navigation_bloc.dart';
import 'package:collaction_cms/presentation/modals/invite_admin.dart';
import 'package:collaction_cms/presentation/navigation/widgets/navigation_item.dart';
import 'package:collaction_cms/presentation/navigation/widgets/special_navigation_item.dart';
import 'package:collaction_cms/presentation/go_routing/routes.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:collaction_cms/application/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<NavigationBloc>(context),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 75,
                child: Image.asset(
                  'images/Vector.png',
                  width: 180,
                ),
              ),
              const Divider(height: 0, color: kBorderColor),
              const SizedBox(height: 35.0),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return SpecialNavigationItem(
                      icon: Icons.add_circle_outline,
                      label: 'Invite Admin',
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext builder) {
                              return InviteAdminModal();
                            }).then((value) => BlocProvider.of<AuthBloc>(context).add(const AuthEvent.authCheckRequested()));
                      });
                },
              ),
              const SizedBox(height: 35.0),
              NavigationItem(
                key: GlobalKey<State>(),
                icon: Icons.devices_other_outlined,
                isActive: state.route == dashboard,
                label: 'Dashboard',
                onTap: () => BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPageEvent(route: dashboard)),
              ),
              const SizedBox(height: 10),
              NavigationItem(
                key: GlobalKey<State>(),
                icon: Icons.dns_outlined,
                isActive: state.route == crowdAction,
                label: 'CrowdActions',
                onTap: () {
                  BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPageEvent(route: crowdAction));
                },

              ),
              const SizedBox(height: 10),
              NavigationItem(
                key: GlobalKey<State>(),
                icon: Icons.insert_comment_outlined,
                isActive: state.route == moderationQueue,
                label: 'Moderation Queue',
                onTap: () => BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPageEvent(route: moderationQueue)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(const AuthEvent.signedOut());
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(width: 100, height: 20),
                      Positioned(
                        right: 70,
                        child: SvgPicture.asset(
                          width: 14,
                          "icons/sign_out.svg",
                          color: Colors.red[400],
                        ),
                      ),
                      Positioned(
                        left: 40,
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                              fontFamily: "Rubik",
                              color: Colors.red[400],
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
