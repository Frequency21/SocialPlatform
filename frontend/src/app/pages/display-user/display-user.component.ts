import { browser } from 'protractor';
import { Subscription } from 'rxjs';
import { PosztService } from './../../services/poszt.service';
import { ModalPosztComponent } from './../modal-poszt/modal-poszt.component';
import { MatDialog } from '@angular/material/dialog';
import { UserService } from 'src/app/services/user.service';
import { User } from './../../shared/models/user.model';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Poszt } from 'src/app/shared/models/poszt.model';
import { ModalKommentComponent } from '../modal-komment/modal-komment.component';

@Component({
  selector: 'app-display-user',
  templateUrl: './display-user.component.html',
  styleUrls: ['./display-user.component.scss']
})
export class DisplayUserComponent implements OnInit {

  @Input() user!: User;
  poszts?: Poszt[];
  currentUser?: User;
  subscription: Subscription;

  constructor(
    private _Activatedroute: ActivatedRoute,
    private userService: UserService,
    private posztService: PosztService,
    public dialog: MatDialog
  ) {
    this.subscription = this.userService.userSource.subscribe(user => this.currentUser = user);
  }

  ngOnInit(): void {
    this._Activatedroute.paramMap.subscribe(params => {
      this.getUser(Number(params.get("id")));
      this.getPoszts(Number(params.get("id")));
    });

  }

  getUser(id: number): void {
    this.userService.getUserByID(id).subscribe(user => {
      this.user = user;
    });
  }

  getPoszts(id: number): void {
    this.posztService.getPosztsByFelhasznaloId(id).subscribe(poszts => {
      this.poszts = poszts;
    });
  }

  getDate(): number {
    if (!this.user) return 0;
    return this.user.csatl.getTime();
  }

  openPosztDialog(){
    const dialogRef = this.dialog.open(ModalPosztComponent, {
      width: '40%',
      data: {szerzo_id : this.currentUser?.id, szerzo_nev: this.currentUser?.knev+ " "+this.currentUser?.vnev, szerzo_profilkep: this.currentUser?.picture, csoport_id:undefined, felhasznalo_id:this.user.id}
    });

    dialogRef.afterClosed().subscribe(result => {
      // console.log('The dialog was closed');
    });
  }

  openKommentDialog(val_id: number): void {
    console.log("poszt id: " + Number(val_id));
    const dialogRef = this.dialog.open(ModalKommentComponent, {
      width: '40%',
      data: {komment_iro_id : this.currentUser?.id, poszt_felh_id: val_id, poszt_idopont: ""}
    });

    dialogRef.afterClosed().subscribe(result => {
    });
  }

  isLoggedIn() {
    return this.currentUser == undefined;
  }

}
