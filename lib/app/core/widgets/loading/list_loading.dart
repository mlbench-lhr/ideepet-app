import 'package:flutter/material.dart';
import 'package:idee_pet/app/app.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ListLoading extends StatelessWidget {
  const ListLoading({super.key});

  @override
  Widget build(BuildContext context) => Skeletonizer(
        enabled: true,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: 7,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) => MedRecordCardEmpty(
            medRecord: MedicalRecordResponse.empty(),
          ),
        ),
      );
}
