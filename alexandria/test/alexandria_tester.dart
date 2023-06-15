import 'dart:ffi';

import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/Utente.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:alexandria/globals.dart';
import 'package:test/test.dart';

void main() {
  group('Test categorie', () {
    Categoria? prima_categoria;
    Categoria? seconda_categoria;
    Riferimento? riferimento;
    test('Creazione categoria', () async {
      final cat = await networkHelper.createCategoria('TestCategoria', 1, null);
      expect('TestCategoria', cat?.nome);
      expect(null, cat?.super_Categoria);
      expect(1, cat?.user_id);
      prima_categoria = cat;
    });
    test('Test sopra-categoria', () async {
      final cat = await networkHelper.createCategoria('TestCategoria2', 1, prima_categoria?.id_categoria);
      final sopraCategorie = await networkHelper.getSopraCategorie(cat!.id_categoria);
      seconda_categoria = cat;
      expect(sopraCategorie?[0], prima_categoria?.id_categoria);
      expect(sopraCategorie, null);
    });
    test('Test eliminazione categoria', () async {
      final eliminaPrimaCategoria = await networkHelper.deleteCategoria(prima_categoria!);
      final eliminaSecondaCategoria = await networkHelper.deleteCategoria(seconda_categoria!);
      expect(eliminaPrimaCategoria, true);
      expect(eliminaPrimaCategoria, false);
      expect(eliminaSecondaCategoria, true);
      expect(eliminaSecondaCategoria, false);
    });
    test('Test aggiorna riferimento autore', () async {
      riferimento = Riferimento(-1, "TestRiferimento", DateTime.now(), tipo_enum.Libro, null, null, false, "descr_riferimento", "editore", null, null, null, null, null, null);
      final aggiornaRiferimentoAutore = await networkHelper.aggiornaRiferimentoAutore(riferimento!, 1, 2);
      expect(aggiornaRiferimentoAutore, true);
      expect(aggiornaRiferimentoAutore, false);
    });
  });

  // group('Test riferimenti', ()
  // {
  //   Riferimento? primo_riferimento;
  //   Riferimento? secondo_riferimento;
  //   test('Creazione riferimento', () async {
  //     final cat = await networkHelper.createRiferimento('TestCategoria', 1, null);
  //     expect('TestCategoria', cat?.nome);
  //     expect(null, cat?.super_Categoria);
  //     expect(1, cat?.user_id);
  //     prima_categoria = cat;
  //   });
  //   test('Test sopra-categoria', () async {
  //     final cat = await networkHelper.createCategoria('TestCategoria2', 1, prima_categoria?.id_categoria);
  //     final sopraCategorie = await networkHelper.getSopraCategorie(cat!.id_categoria);
  //     seconda_categoria = cat;
  //     expect(sopraCategorie?[0], prima_categoria?.id_categoria);
  //   });
  //   test('Test eliminazione categoria', () async {
  //     final eliminaPrimaCategoria = await networkHelper.deleteCategoria(prima_categoria!);
  //     final eliminaSecondaCategoria = await networkHelper.deleteCategoria(seconda_categoria!);
  //     expect(eliminaPrimaCategoria, true);
  //     expect(eliminaSecondaCategoria, true);
  //   });
  // });
}
