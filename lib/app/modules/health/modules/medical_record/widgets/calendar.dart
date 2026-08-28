import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/helps/functions.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void showCalendarModalMedicalRecord({
  required BuildContext context,
  DateTime? initialDate,
  required void Function(DateTime) onDateSelected,
}) {
  DateTime selectedDay = initialDate ?? DateTime.now();
  DateTime focusedDay = selectedDay;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(16.0),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// **Cabeçalho do Calendário com Título e Setas**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left, size: 28),
                      onPressed: () {
                        setState(() {
                          focusedDay = DateTime(
                              focusedDay.year, focusedDay.month - 1, 1);
                        });
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          firstLetterUpper(
                              DateFormat.MMMM('pt_BR').format(focusedDay)),
                          style: AppTextStyles.robotoMedium(
                                  fontSize: 18, color: AppColors.primary)
                              .style,
                        ),
                        Text(
                          focusedDay.year.toString(),
                          style: AppTextStyles.robotoMedium(
                                  fontSize: 11, color: AppColors.grey)
                              .style,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right, size: 28),
                      onPressed: () {
                        setState(() {
                          focusedDay = DateTime(
                              focusedDay.year, focusedDay.month + 1, 1);
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(height: 8),

                /// **Calendário**
                TableCalendar(
                  locale: 'pt_BR',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDay = selected;
                      focusedDay = focused;
                    });
                  },
                  onPageChanged: (newFocusedDay) {
                    setState(() {
                      focusedDay = newFocusedDay;
                    });
                  },
                  headerVisible: false,
                  calendarStyle: CalendarStyle(
                    cellMargin:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    defaultTextStyle: AppTextStyles.robotoMedium(
                            fontSize: 15, color: Colors.black)
                        .style,
                    disabledTextStyle: AppTextStyles.robotoMedium(
                            fontSize: 15, color: AppColors.greyWhite)
                        .style,
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.greyWhite,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) => DateFormat.E(locale)
                        .format(date)
                        .substring(0, 1)
                        .toUpperCase(),
                    weekdayStyle: AppTextStyles.robotoMedium(
                            fontSize: 15, color: AppColors.primary)
                        .style,
                    weekendStyle: AppTextStyles.robotoMedium(
                            fontSize: 15, color: AppColors.primary)
                        .style,
                  ),
                ),

                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      onDateSelected(selectedDay);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: AppColors.grey,
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                      shadowColor: AppColors.primary.withAlpha(80),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Salvar',
                          style: AppTextStyles.poppinsSemiBold(
                            color: AppColors.background,
                          ).style,
                        )
                      ],
                    ),
                  ),
                ),

                /// **Botão Salvar**
                // CustomButton.filled(
                //   action: () {
                //     onDateSelected(selectedDay);
                //     Navigator.pop(context);
                //   },
                //   title: Text(
                //     'Salvar',
                //     style: AppTextStyles.poppinsSemiBold(
                //       color: AppColors.background,
                //     ).style,
                //   ),
                // ),
              ],
            );
          },
        ),
      );
    },
  );
}
