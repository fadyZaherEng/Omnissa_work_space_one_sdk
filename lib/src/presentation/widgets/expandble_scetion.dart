import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';

class ExpandableSection extends StatefulWidget {
  final String title;
  final String value;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function()? onEdit;
  final bool isPadding;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.value,
    required this.isExpanded,
    required this.onToggle,
    this.isPadding = true,
    this.onEdit,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool isShowMore = false;

  @override
  void initState() {
    super.initState();
    isShowMore = widget.value.length > 100;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: widget.isPadding ? 16 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.primary,
                        fontWeight: Constants.fontWeightSemiBold,
                        fontSize: 15,
                      ),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onToggle();
                  setState(() {
                    isShowMore = widget.value.length > 100;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),

          // Body (only when expanded)
          if (widget.isExpanded) ...[
            const SizedBox(height: 4),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: [
                Text(
                  widget.value,
                  maxLines: !isShowMore ? 1000 : 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.black,
                      ),
                ),
                const SizedBox(width: 8),
                if (isShowMore)
                  InkWell(
                    onTap: () {
                      setState(() {
                        isShowMore = !isShowMore;
                      });
                    },
                    child: Text(
                      S.of(context).showMore,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorSchemes.primary,
                          ),
                    ),
                  ),
              ],
            ),
            if (widget.onEdit != null)
              //add edit button
              const SizedBox(height: 8),
            if (widget.onEdit != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: widget.onEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSchemes.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      S.of(context).edit,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.white,
                          ),
                    ),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
