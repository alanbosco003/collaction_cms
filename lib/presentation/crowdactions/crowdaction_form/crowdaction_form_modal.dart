import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/crowdaction_info_form.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

class CrowdActionFormModal extends StatefulWidget {
  final CrowdAction? crowdAction;
  const CrowdActionFormModal({
    super.key,
    this.crowdAction,
  });

  @override
  State<CrowdActionFormModal> createState() => _CrowdActionFormModalState();
}

class _CrowdActionFormModalState extends State<CrowdActionFormModal> {
  late final String modalTitle;

  @override
  void initState() {
    super.initState();
    widget.crowdAction != null ? setupForm(widget.crowdAction) : emptyForm();
  }

  void setupForm(CrowdAction? crowdAction) {
    modalTitle = "Edit CrowdAction";
  }

  void emptyForm() {
    modalTitle = "New CrowdAction";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1032,
      height: 875,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(height: 22),
            Text(
              modalTitle,
              style: CollactionTextStyles.titleStyle26,
            ),
            const SizedBox(height: 22),
            Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Color(0xFF8B8B8B),
                    width: 0.25,
                  ),
                ),
              ),
              width: double.infinity,
              height: 710,
              child: SingleChildScrollView(
                child: DeferredPointerHandler(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        /*LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Row(
                              children: [
                                CrowdActionInfoForm(
                                    width: constraints.maxWidth * 0.5 - 5),
                                const SizedBox(width: 10),
                                CrowdActionInfoForm(
                                    width: constraints.maxWidth * 0.5 - 5),
                              ],
                            );
                          },
                        ),
                        CrowdActionInfoForm(width: double.infinity),*/
                        Placeholder(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  CollActionButtonRectangle(
                    text: "Save CrowdAction",
                    onPressed: () {},
                    width: 157,
                    height: 37,
                    padding: 0,
                  ),
                  CollActionButtonRectangle(
                    text: "Cancel",
                    onPressed: () => Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pop('dialog'),
                    width: 157,
                    height: 37,
                    padding: 0,
                    inverted: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCrowdActionFormModal(
    BuildContext context, CrowdAction? crowdAction) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: CrowdActionFormModal(
        crowdAction: crowdAction,
      ),
    ),
  );
}
