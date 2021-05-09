import { GroupDialog } from './../../shared/models/groupDialog.modell';
import { Router } from '@angular/router';
import { CommentService } from './../../services/comment.service';
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
  komments?: Komment[];

  constructor(
    private router: Router,
    public dialogRef: MatDialogRef<ModalKommentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: GroupDialog,
    private posztService: PosztService,
    private commentService: CommentService
  ) { }

  ngOnInit(): void {
    this.getKomments();
  }

  posztKomment(): void {
    let newKomment: Komment = {
      idopont: "",
      komment_iro_id: this.data.komment_iro_id,
      szerzo_knev: "",
      szerzo_vnev: "",
      poszt_id: Number(this.data.poszt_id),
      szoveg: this.form.value.szoveg,
      ertekeles : {
        like : 0,
        dislike : 0
      },
      isPublic: (this.form.value.isPublic != null)
    }
    console.log(newKomment);
    this.commentService.saveKomment(newKomment).subscribe(retKomment => {
      console.log(retKomment);
    });
    this.onNoClick();
  }

  getKomments(): void {
    console.log(this.data.poszt_id);
    this.commentService.getKommnetByPosztId(Number(this.data.poszt_id)).subscribe(komments => {
      this.komments = komments;
      console.log(this.komments);
    })
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

}
