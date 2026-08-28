import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idee_pet/app/app.dart';

class CardProfileWidget extends StatefulWidget {
  final Pet pet;
  final void Function(Pet pet) setPet;
  final double? elevation;
  final Profile profile;
  final List<Pet> pets;
  final VoidCallback addNewPet;
  final VoidCallback editPet;

  const CardProfileWidget(
      {super.key,
      required this.pet,
      required this.setPet,
      this.elevation,
      required this.profile,
      required this.pets,
      required this.addNewPet,
      required this.editPet});

  @override
  State<CardProfileWidget> createState() => _CardProfileState();
}

class _CardProfileState extends State<CardProfileWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Card(
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: AppColors.primary,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.pet.name,
                                style: AppTextStyles.poppinsSemiBold(
                                        fontSize: 32,
                                        color: AppColors.background)
                                    .style,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showPetSelector(
                                  context,
                                  widget.setPet,
                                  widget.pet,
                                  widget.pets,
                                  widget.addNewPet,
                                );
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.secundary,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                        Text(widget.pet.breed?.name ?? 'Desconhecido',
                            style: AppTextStyles.poppinsMedium(
                                    fontSize: 12, color: AppColors.secundary)
                                .style),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Text(
                                  'ID: ${isVisible ? widget.pet.id : '*************'}',
                                  style: AppTextStyles.robotoMedium(
                                          fontSize: 12,
                                          color: AppColors.background)
                                      .style),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.background,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Verified ${formatMonthYear(widget.pet.updatedAt)}',
                        style: AppTextStyles.robotoMedium(
                                fontSize: 8, color: AppColors.background)
                            .style,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => widget.editPet(),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircularImageWidget(
                              imageUrl: widget.pet.avatarUrl,
                              size: 60,
                            ),
                            Positioned(
                              bottom: -6,
                              right: -6,
                              child: Container(
                                  padding: EdgeInsets.all(4),
                                  child:
                                      SvgPicture.asset('assets/edit/edit.svg')),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.qr_code,
                          color: AppColors.background, size: 60),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: WalletPet(
              pet: widget.pet,
              profile: widget.profile,
            ),
          ),
        ),
      ],
    );
  }
}
