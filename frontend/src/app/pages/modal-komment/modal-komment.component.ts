import { KommentDialog } from './../../shared/models/kommentDialog.model';
import { Komment } from './../../shared/models/komment.model';
import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { DialogData } from 'src/app/shared/models/postDialog.model';
import { PosztService } from 'src/app/services/poszt.service';

@Component({
  selector: 'app-modal-komment',
  templateUrl: './modal-komment.component.html',
  styleUrls: ['./modal-komment.component.scss']
})
export class ModalKommentComponent implements OnInit {

  form: FormGroup = new FormGroup({
    szoveg: new FormControl(),
    isPublic: new FormControl()
  });

  constructor(
    public dialogRef: MatDialogRef<ModalKommentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: KommentDialog,
    private posztService: PosztService
  ) { }

  ngOnInit(): void {
  }

  posztKomment(): void {
    let newKomment: Komment = {
      idopont: "",
      komment_iro_id: this.data.komment_iro_id,
      poszt_felh_id: this.data.poszt_felh_id,
      poszt_idopont: this.data.poszt_idopont,
      szoveg: this.form.value.szoveg,
      ertekeles : {
        like : 0,
        dislike : 0
      },
      isPublic: (this.form.value.isPublic != null)
    }
    console.log(newKomment);
    this.posztService.addKomment(newKomment).subscribe(retKomment => {
      console.log(retKomment);
    });
    this.onNoClick();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

}
