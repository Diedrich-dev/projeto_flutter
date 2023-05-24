class CartaoEntity {
  late int? cartaoID;
  String? descricao;
  late int? numero;
  late DateTime? validade;
  String? cvv;
  String? senha;

  CartaoEntity({
    this.descricao,
    this.numero,
    this.validade,
    this.cvv,
    this.senha,
  });
}
