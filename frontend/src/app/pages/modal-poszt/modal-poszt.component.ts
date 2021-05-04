import { DialogData } from './../../shared/models/postDialog.model';
import { Poszt } from 'src/app/shared/models/poszt.model';
import { FormGroup, FormControl } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Inject } from '@angular/core';

@Component({
  selector: 'app-modal-poszt',
  templateUrl: './modal-poszt.component.html',
  styleUrls: ['./modal-poszt.component.scss']
})
export class ModalPosztComponent implements OnInit {

  csoport_id?: number;

  form: FormGroup = new FormGroup({
    szoveg: new FormControl(),
    isPublic: new FormControl()
  });

  constructor(
    public dialogRef: MatDialogRef<ModalPosztComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData
  ) { }

  ngOnInit(): void {
  }

  addPoszt(): void {
    var newPost: Poszt = {
      idopont : (new Date().toLocaleString()),
      szerzo_id : this.data.szerzo_id,

      szerzo_nev : this.data.szerzo_nev,
      szerzo_profil_kep : this.data.szerzo_profilkep,
      csoport_id : this.data.csoport_id,
      felhasznalo_id : this.data.felhasznalo_id,
      szoveg : this.form.value.szoveg,
      ertekeles : {
        like : 0,
        dislike : 0
      },
      isPublic : !(this.form.value.isPublic)
    };
    console.log(newPost);
    this.onNoClick();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

}
