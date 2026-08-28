import 'package:flutter/material.dart';
import 'package:idee_pet/app/app.dart';

void showPetSelector(
  BuildContext context,
  Function(Pet) onSelected,
  Pet selectedPet,
  List<Pet> pets,
  VoidCallback addNewPet,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: AppColors.white,
    builder: (BuildContext context) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        // Removido o Padding geral daqui
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. --- CABEÇALHO FIXO E VISÍVEL ---
            Container(
              color: AppColors.white, // GARANTE QUE O FUNDO ESCONDE O CONTEÚDO
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mudança de perfil',
                    style: AppTextStyles.title(
                      color: AppColors.primary,
                      fontSize: 16,
                    ).style,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.greyWeak,
                    ),
                  )
                ],
              ),
            ),
            // 2. --- LISTA ROLÁVEL (Área Flexible) ---
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  // shrinkWrap: true foi removido na correção anterior
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    final isSelected = pet.id == selectedPet.id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        // ... seu ListTile ...
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.greyWeak,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        leading: CircularImageWidget(imageUrl: pet.avatarUrl),
                        title: Text(
                          pet.name,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.poppinsMedium(
                            color: AppColors.greyWeak,
                            fontSize: 14,
                          ).style,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        onTap: isSelected
                            ? null
                            : () {
                                onSelected(pet);
                                Navigator.pop(context);
                              },
                      ),
                    );
                  },
                ),
              ),
            ),
            // 3. --- RODAPÉ FIXO E VISÍVEL ---
            Container(
              color: AppColors.white, // MÁSCARA DE ROLAGEM
              padding: const EdgeInsets.only(
                  bottom: 40, top: 10, left: 20, right: 20),
              child: Container(
                // Este Container agora é responsável pela Borda, Background e Arredondamento
                decoration: BoxDecoration(
                  color: AppColors.white, // Opcional: Garante o branco no fundo
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.greyWeak, // A BORDA AGORA DEVE SER VISÍVEL
                    width: 2,
                  ),
                ),
                // Movemos o ListTile para dentro do Container que tem a borda
                child: ListTile(
                  // Removido o 'shape: RoundedRectangleBorder' daqui,
                  // pois a borda está sendo desenhada no Container pai.
                  leading:
                      const Icon(Icons.add, color: AppColors.primary, size: 28),
                  title: Text(
                    "Adicionar outro pet",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.poppinsMedium(
                      color: AppColors.primary,
                      fontSize: 14,
                    ).style,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  onTap: addNewPet,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
