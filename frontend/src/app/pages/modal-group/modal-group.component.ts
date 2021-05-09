import { GroupService } from './../../services/group.service';
import { GroupDialog } from './../../shared/models/groupDialog.modell';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Group } from 'src/app/shared/models/group.model';
import { FormGroup, FormControl } from '@angular/forms';
import { Component, Inject, OnInit } from '@angular/core';

@Component({
  selector: 'app-modal-group',
  templateUrl: './modal-group.component.html',
  styleUrls: ['./modal-group.component.scss']
})
export class ModalGroupComponent implements OnInit {

  form: FormGroup = new FormGroup({
    nev: new FormControl(),
    leiras: new FormControl()
  });

  constructor(
    public dialogRef: MatDialogRef<ModalGroupComponent>,
    @Inject(MAT_DIALOG_DATA) public data: GroupDialog,
    private groupService: GroupService
  ) { }

  ngOnInit(): void {
  }

  saveGroup(): void {
    var newGroup: Group = {
      csoport_id: undefined,
      leiras: this.form.value.leiras,
      nev: this.form.value.nev,
      tulaj_id: this.data.tulaj_id,
      tagok: undefined
    }
    this.groupService.addGroup(newGroup).subscribe(ret => {
      console.log(ret);
    })
    this.onNoClick();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }


}
