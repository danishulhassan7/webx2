import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';

class PTab extends StatelessWidget {
  const PTab({
    Key? key,
    this.count = 0,
    required this.label,
  }) : super(key: key);

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Text(label),
          if (count > 0) ...[
            SizedBox(width: 10),
            Container(
              height: 18,
              width: 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${count}',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
