class Evento {
  String name;
  String description;
  String data;
  String location;
  String longDescription;
  String imagePath;
  // TODO: Colocar o ngc da localização
  Evento(
      {required this.name,
      required this.description,
      required this.data,
      required this.location,
      required this.longDescription,
      required this.imagePath});
}
