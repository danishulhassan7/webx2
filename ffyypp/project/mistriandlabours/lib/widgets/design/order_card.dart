import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/job_application.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key? key,
    required JobApplication application,
    this.onNegativeBtnClicked,
    this.onPositiveBtnClicked,
    required this.postiveLabel,
    required this.negativeLabel,
  })  : _application = application,
        super(key: key);

  final JobApplication _application;
  final Function(JobApplication)? onPositiveBtnClicked;
  final Function(JobApplication)? onNegativeBtnClicked;
  final String postiveLabel;
  final String negativeLabel;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget._application.title,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Text(
                        'Rs.${widget._application.payment}',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget._application.date} ${widget._application.time}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        widget._application.location,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${widget._application.description}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  if (widget._application.additionalInfo?.isNotEmpty ??
                      false) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(widget._application.additionalInfo!),
                    ),
                    SizedBox(height: 10),
                  ],
                  Row(
                    children: [
                      if (widget.onPositiveBtnClicked != null)
                        Theme(
                          data: Theme.of(context).copyWith(
                            elevatedButtonTheme: ElevatedButtonThemeData(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.greenColor),
                                  ),
                            ),
                          ),
                          child: PElevatedButton(
                            label: widget.postiveLabel,
                            onPressed: () async {
                              await widget.onPositiveBtnClicked
                                  ?.call(widget._application);
                            },
                          ),
                        ),
                      if (widget.onPositiveBtnClicked != null)
                        SizedBox(width: 10),
                      if (widget.onNegativeBtnClicked != null)
                        Theme(
                          data: Theme.of(context).copyWith(
                            elevatedButtonTheme: ElevatedButtonThemeData(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.redColor),
                                  ),
                            ),
                          ),
                          child: PElevatedButton(
                            label: widget.negativeLabel,
                            onPressed: () async {
                              await widget.onNegativeBtnClicked
                                  ?.call(widget._application);
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            isExpanded: _isExpanded,
            canTapOnHeader: true,
          ),
        ],
        dividerColor: Colors.grey,
        expansionCallback: (panelIndex, isExpanded) {
          _isExpanded = !_isExpanded;
          setState(() {});
        },
      ),
    );
  }
}
