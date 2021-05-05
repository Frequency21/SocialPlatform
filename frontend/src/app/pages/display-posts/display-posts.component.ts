import { MatDialog } from '@angular/material/dialog';
import { ModalKommentComponent } from './../modal-komment/modal-komment.component';
import { Component, OnInit } from '@angular/core';
import { PosztService } from 'src/app/services/poszt.service';
import { Poszt } from 'src/app/shared/models/poszt.model';

@Component({
  selector: 'app-display-posts',
  templateUrl: './display-posts.component.html',
  styleUrls: ['./display-posts.component.scss']
})
export class DisplayPostsComponent implements OnInit {

  poszts?: Poszt[];

  constructor(
    private posztService: PosztService,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    this.getPoszts();
  }

  getPoszts(): void {
    this.posztService.getPoszts().subscribe(poszts => {
      this.poszts = poszts;
      console.log(poszts);
      console.log(this.poszts);
    });
  }

  openDialog(val_id: number): void {
    const dialogRef = this.dialog.open(ModalKommentComponent, {
      width: '40%',
      //Ide kellene Deny, és a bejelentkezése
      data: {komment_iro_id : undefined, poszt_felh_id: val_id, poszt_idopont: ""}
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

}
