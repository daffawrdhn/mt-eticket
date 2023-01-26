import 'dart:async';

import 'dart:io';

class ValidatorsAdd {

  final validateFeature = StreamTransformer<int, int>.fromHandlers(
      handleData: (feature, sink) {
        if (feature != null) {
          if (feature.toString().contains(RegExp(r'^(?=.*?[0-9]).{1,2}$'))) {
            sink.add(feature);
          } else {
            sink.addError('Invalid Feature');
          }
        }
      }
  );

  final validateSubfeature = StreamTransformer<int, int>.fromHandlers(
      handleData: (subfeature, sink) {
        if (subfeature != null) {
          if (subfeature.toString().contains(RegExp(r'^(?=.*?[0-9]).{1,2}$'))) {
            sink.add(subfeature);
          } else {
            sink.addError('Invalid Feature');
          }
        }
      }
  );

  final validateTitle = StreamTransformer<String, String>.fromHandlers(
      handleData: (title, sink) {
        if(title != null){
          if (title.length > 100) {
            sink.addError('Title must be 100 characters or less');
          } else if (title.contains(RegExp(r'^(?=.{1,100}$)'))) {
            sink.add(title);
          } else {
            sink.addError('Please input Ticket Title');
          }
        }
      }
  );

  final validateDescription = StreamTransformer<String, String>.fromHandlers(
      handleData: (description, sink) {
        if(description != null){
          if (description.trim().isNotEmpty) {
            sink.add(description);
          } else {
            sink.addError('Please input Ticket Description');
          }
        }
      }
  );


  final validatePhoto = StreamTransformer<File, File>.fromHandlers(
      handleData: (photo, sink) {
        // Check if the file extension is one of the allowed types
        if (photo != null &&
            (photo.path.endsWith('.jpg') ||
                photo.path.endsWith('.jpeg') ||
                photo.path.endsWith('.png'))) {
          sink.add(photo);
        } else {
          sink.addError('Invalid photo file');
        }
      }
  );

}