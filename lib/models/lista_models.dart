const String LISTACOMPRAS_TABLE = "listacompras";
const String LISTACOMPRAS_FIELD_ID = "id";
const String LISTACOMPRAS_FIELD_ITEM = "item";
const String LISTACOMPRAS_FIELD_COMPRADO = "comprado";

class ListaModel {
  int? id;
  String item = '';
  bool comprado = false;

  ListaModel({
    this.id,
    required this.item,
    required this.comprado
  });

  // Serialização. Cria um novo item da tua lista de compras
  ListaModel.fromJson(Map<String, dynamic>json){
    this.id = json[LISTACOMPRAS_FIELD_ID]; // Guarda o ID no atributo ID
    this.item = json[LISTACOMPRAS_FIELD_ITEM]; // Guarda o ITEM no atributo ITEM
    this.comprado = json[LISTACOMPRAS_FIELD_COMPRADO] == 1; // Guarda o COMPRADO no atributo COMPRADO
  }

  //Deserilização
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      LISTACOMPRAS_FIELD_ITEM: item,
      LISTACOMPRAS_FIELD_COMPRADO: comprado
    };

    if (id != null)
      json[LISTACOMPRAS_FIELD_ID] = id;

    return json;
  }
}