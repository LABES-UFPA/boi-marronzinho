import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_module.dart';
import 'package:get/get.dart';

class OficinasAdmController extends BaseController {
  final oficinasRepo = OficinasRepository();
  //RxBool get isLoading => super.isLoading;
  //var isLoading = true.obs;
  List<Oficina> oficinas = <Oficina>[];

  @override
  void onInit() {
    super.onInit();
    getOficinasTeste();
  }

  Future<void> getOficinas() async {
    setLoading(true); // Você pode ter uma função para mostrar um loader.

    final response = await oficinasRepo.fetchOficinas();
    final isValid = isValidResponse(response: response, title: 'Ovo Frito');
    if (isValid && response.data != null) {
      oficinas = response.data;
    }

    setLoading(false); // Finaliza o loader aqui.
    update(); // Atualiza a interface do GetX.
  }

  Future<void> getOficinasTeste() async {
    setLoading(true); // Exibe o loading na tela
    await Future.delayed(
        Duration(seconds: 2)); // Simula um tempo de resposta da API

    // Simulação de dados de vouchers
    oficinas = [
      Oficina(
        id: '03eb71d0-2d5e-4dac-974c-903e1137eac5',
        usuarioId: '084b64e1-250c-44df-a809-4caa32b0e0fd',
        nomeOficina: 'Oficina de Desenvolvimento Web',
        descricao:
            'Uma oficina para aprender o básico do desenvolvimento web utilizando Go.',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEAAQMAAABmvDolAAAABlBMVEX///8AAABVwtN+AAABjUlEQVR42uyYMY70IAyFH0pBOUfIUTgaHI2j5AiUKSLeL9swyeifbVcbKy4iOfoajLGfjccee+zP2otiOxK7OiXs85crYAOwiNfFTbz+8gQk9kXODsS2kn3+8gkUHvrDN1Ahqbwlht0noClsD5abxeFL2t8dsIL0qjkcsa01/1DEbg5MrmY5uj7e743n3oCksHacAkS5botDvx1Q9JiQErTWTDvs9fG6AOQhsiWptOpEbmmWXUfA8LL2zZq7APQGyA1jIaUEKR12rBXhLEFOADIckSx94dWcASJjFzZkkg2Yleq8bh/AKjIvssKULXtsuKogR4BEQOSBRMDK1kdWOwBeGzKP2Oa8yUCZU/wBqYznOiaUKLntD7CLtnkTGB3nKvZ8AOmd1bok+QjKXYD3HKKYiT0RuMvuCjiHqqDjZNapufy/uLs5MKfmolgaX3/A3Gj1IQw0MOHwCdSsWB3XTa8AwhFN7LXVhk9fgK2vUlEVlDjaCpwBY6P13ouoXy5Z7QJ47LHHft3+BQAA//9JCjJ1J8W9eAAAAABJRU5ErkJggg==',
      ),
      Oficina(
        id: '2dbb71d0-2d5e-4dac-974c-903e1137eac5',
        usuarioId: '184b64e1-250c-44df-a809-4caa32b0e0fd',
        nomeOficina: 'Oficina de Flutter',
        descricao: 'Oficina para aprender Flutter e criar aplicativos mobile.',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEAAQMAAABmvDolAAAABlBMVEX///8AAABVwtN+AAABjUlEQVR42uyYMY70IAyFH0pBOUfIUTgaHI2j5AiUKSLeL9swyeifbVcbKy4iOfoajLGfjccee+zP2otiOxK7OiXs85crYAOwiNfFTbz+8gQk9kXODsS2kn3+8gkUHvrDN1Ahqbwlht0noClsD5abxeFL2t8dsIL0qjkcsa01/1DEbg5MrmY5uj7e743n3oCksHacAkS5botDvx1Q9JiQErTWTDvs9fG6AOQhsiWptOpEbmmWXUfA8LL2zZq7APQGyA1jIaUEKR12rBXhLEFOADIckSx94dWcASJjFzZkkg2Yleq8bh/AKjIvssKULXtsuKogR4BEQOSBRMDK1kdWOwBeGzKP2Oa8yUCZU/wBqYznOiaUKLntD7CLtnkTGB3nKvZ8AOmd1bok+QjKXYD3HKKYiT0RuMvuCjiHqqDjZNapufy/uLs5MKfmolgaX3/A3Gj1IQw0MOHwCdSsWB3XTa8AwhFN7LXVhk9fgK2vUlEVlDjaCpwBY6P13ouoXy5Z7QJ47LHHft3+BQAA//9JCjJ1J8W9eAAAAABJRU5ErkJggg==',
      ),
      Oficina(
        id: '2dbb71d0-2d5e-4dac-974c-903e1137eac5',
        usuarioId: '184b64e1-250c-44df-a809-4caa32b0e0fd',
        nomeOficina: 'Oficina de Java',
        descricao: 'Oficina para aprender Flutter e criar aplicativos mobile.',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEAAQMAAABmvDolAAAABlBMVEX///8AAABVwtN+AAABjUlEQVR42uyYMY70IAyFH0pBOUfIUTgaHI2j5AiUKSLeL9swyeifbVcbKy4iOfoajLGfjccee+zP2otiOxK7OiXs85crYAOwiNfFTbz+8gQk9kXODsS2kn3+8gkUHvrDN1Ahqbwlht0noClsD5abxeFL2t8dsIL0qjkcsa01/1DEbg5MrmY5uj7e743n3oCksHacAkS5botDvx1Q9JiQErTWTDvs9fG6AOQhsiWptOpEbmmWXUfA8LL2zZq7APQGyA1jIaUEKR12rBXhLEFOADIckSx94dWcASJjFzZkkg2Yleq8bh/AKjIvssKULXtsuKogR4BEQOSBRMDK1kdWOwBeGzKP2Oa8yUCZU/wBqYznOiaUKLntD7CLtnkTGB3nKvZ8AOmd1bok+QjKXYD3HKKYiT0RuMvuCjiHqqDjZNapufy/uLs5MKfmolgaX3/A3Gj1IQw0MOHwCdSsWB3XTa8AwhFN7LXVhk9fgK2vUlEVlDjaCpwBY6P13ouoXy5Z7QJ47LHHft3+BQAA//9JCjJ1J8W9eAAAAABJRU5ErkJggg==',
      ),
      Oficina(
        id: '2dbb71d0-2d5e-4dac-974c-903e1137eac5',
        usuarioId: '184b64e1-250c-44df-a809-4caa32b0e0fd',
        nomeOficina: 'Curso de Haskell',
        descricao: 'Oficina para aprender Flutter e criar aplicativos mobile.',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEAAQMAAABmvDolAAAABlBMVEX///8AAABVwtN+AAABjUlEQVR42uyYMY70IAyFH0pBOUfIUTgaHI2j5AiUKSLeL9swyeifbVcbKy4iOfoajLGfjccee+zP2otiOxK7OiXs85crYAOwiNfFTbz+8gQk9kXODsS2kn3+8gkUHvrDN1Ahqbwlht0noClsD5abxeFL2t8dsIL0qjkcsa01/1DEbg5MrmY5uj7e743n3oCksHacAkS5botDvx1Q9JiQErTWTDvs9fG6AOQhsiWptOpEbmmWXUfA8LL2zZq7APQGyA1jIaUEKR12rBXhLEFOADIckSx94dWcASJjFzZkkg2Yleq8bh/AKjIvssKULXtsuKogR4BEQOSBRMDK1kdWOwBeGzKP2Oa8yUCZU/wBqYznOiaUKLntD7CLtnkTGB3nKvZ8AOmd1bok+QjKXYD3HKKYiT0RuMvuCjiHqqDjZNapufy/uLs5MKfmolgaX3/A3Gj1IQw0MOHwCdSsWB3XTa8AwhFN7LXVhk9fgK2vUlEVlDjaCpwBY6P13ouoXy5Z7QJ47LHHft3+BQAA//9JCjJ1J8W9eAAAAABJRU5ErkJggg==',
      ),
      Oficina(
        id: '2dbb71d0-2d5e-4dac-974c-903e1137eac5',
        usuarioId: '184b64e1-250c-44df-a809-4caa32b0e0fd',
        nomeOficina: 'Oficina de Pascal',
        descricao: 'Oficina para aprender Flutter e criar aplicativos mobile.',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEAAQMAAABmvDolAAAABlBMVEX///8AAABVwtN+AAABjUlEQVR42uyYMY70IAyFH0pBOUfIUTgaHI2j5AiUKSLeL9swyeifbVcbKy4iOfoajLGfjccee+zP2otiOxK7OiXs85crYAOwiNfFTbz+8gQk9kXODsS2kn3+8gkUHvrDN1Ahqbwlht0noClsD5abxeFL2t8dsIL0qjkcsa01/1DEbg5MrmY5uj7e743n3oCksHacAkS5botDvx1Q9JiQErTWTDvs9fG6AOQhsiWptOpEbmmWXUfA8LL2zZq7APQGyA1jIaUEKR12rBXhLEFOADIckSx94dWcASJjFzZkkg2Yleq8bh/AKjIvssKULXtsuKogR4BEQOSBRMDK1kdWOwBeGzKP2Oa8yUCZU/wBqYznOiaUKLntD7CLtnkTGB3nKvZ8AOmd1bok+QjKXYD3HKKYiT0RuMvuCjiHqqDjZNapufy/uLs5MKfmolgaX3/A3Gj1IQw0MOHwCdSsWB3XTa8AwhFN7LXVhk9fgK2vUlEVlDjaCpwBY6P13ouoXy5Z7QJ47LHHft3+BQAA//9JCjJ1J8W9eAAAAABJRU5ErkJggg==',
      ),
      Oficina(
        id: '2dbb71d0-2d5e-4dac-974c-903e1137eac5',
        usuarioId: '184b64e1-250c-44df-a809-4caa32b0e0fd',
        nomeOficina: 'Oficina de Flutter II',
        descricao: 'Oficina para aprender Flutter e criar aplicativos mobile.',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEAAQMAAABmvDolAAAABlBMVEX///8AAABVwtN+AAABjUlEQVR42uyYMY70IAyFH0pBOUfIUTgaHI2j5AiUKSLeL9swyeifbVcbKy4iOfoajLGfjccee+zP2otiOxK7OiXs85crYAOwiNfFTbz+8gQk9kXODsS2kn3+8gkUHvrDN1Ahqbwlht0noClsD5abxeFL2t8dsIL0qjkcsa01/1DEbg5MrmY5uj7e743n3oCksHacAkS5botDvx1Q9JiQErTWTDvs9fG6AOQhsiWptOpEbmmWXUfA8LL2zZq7APQGyA1jIaUEKR12rBXhLEFOADIckSx94dWcASJjFzZkkg2Yleq8bh/AKjIvssKULXtsuKogR4BEQOSBRMDK1kdWOwBeGzKP2Oa8yUCZU/wBqYznOiaUKLntD7CLtnkTGB3nKvZ8AOmd1bok+QjKXYD3HKKYiT0RuMvuCjiHqqDjZNapufy/uLs5MKfmolgaX3/A3Gj1IQw0MOHwCdSsWB3XTa8AwhFN7LXVhk9fgK2vUlEVlDjaCpwBY6P13ouoXy5Z7QJ47LHHft3+BQAA//9JCjJ1J8W9eAAAAABJRU5ErkJggg==',
      ),
    ];

    setLoading(false); // Finaliza o loader
    update(); // Atualiza a interface com os dados fictícios
  }

  void onAddOficinasPressed() {
    Get.toNamed(AddOficinaModule.path);
  }
}
