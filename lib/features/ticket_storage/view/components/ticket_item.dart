import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/tickets_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/models/ticket_model.dart';

class TicketItem extends StatefulWidget {
  const TicketItem(this.ticket, {super.key});

  final Ticket ticket;

  set totalSize(int totalSize) {
    ticket.totalSize = double.parse((totalSize / 1000000).toStringAsFixed(1));
  }

  set downloadedSize(int downloadedSize) {
    ticket.downloadedSize =
        double.parse((downloadedSize / 1000000).toStringAsFixed(1));
  }

  set downloadProgress(double downloadProgress) {
    ticket.downloadProgress = downloadProgress;
  }

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  CancelToken? _cancelToken;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text(widget.ticket.title),
            trailing: widget.ticket.downloadProgress == 0
                ? IconButton(
                    onPressed: () {
                      // context.read<TicketBloc>().add(TicketLoaded());
                      downloadFile(widget.ticket.title, widget.ticket.url);
                    },
                    icon: const Icon(Icons.download_for_offline_rounded),
                  )
                : widget.ticket.downloadProgress == 100
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.download_done_rounded),
                      )
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.pause_circle_filled_rounded),
                      )),
        LinearProgressIndicator(
          value: widget.ticket.downloadProgress / 100,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: widget.ticket.downloadProgress == 0
              ? const Text('Ожидает начала загрузки')
              : widget.ticket.downloadProgress == 100
                  ? const Text('Файл загружен')
                  : Text(
                      'Загружается ${widget.ticket.downloadedSize} из ${widget.ticket.totalSize} : ${(widget.ticket.downloadProgress).toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 16),
                    ),
        ),
      ],
    );
  }

  void downloadFile(String title, String url) async {
    Dio dio = Dio();
    final directory = await getApplicationDocumentsDirectory();

    String savePath = '${directory.path}/$title';

    await dio.download(url, savePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
      if (totalBytes != -1) {
        double percentage = receivedBytes / totalBytes * 100;
        setState(() {
          widget.downloadedSize = receivedBytes;
          widget.totalSize = totalBytes;
          widget.downloadProgress = percentage;
        });
      }
    });
  }
}
