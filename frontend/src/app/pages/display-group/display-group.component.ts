import { UserService } from 'src/app/services/user.service';
import { GroupService } from './../../services/group.service';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Group } from 'src/app/shared/models/group.model';
import { Poszt } from 'src/app/shared/models/poszt.model';
import { PosztService } from 'src/app/services/poszt.service';
import { User } from 'src/app/shared/models/user.model';
import { Subscription } from 'rxjs';
import { ModalPosztComponent } from '../modal-poszt/modal-poszt.component';
import { MatDialog } from '@angular/material/dialog';
import { ModalKommentComponent } from '../modal-komment/modal-komment.component';

@Component({
  selector: 'app-display-group',
  templateUrl: './display-group.component.html',
  styleUrls: ['./display-group.component.scss']
})
export class DisplayGroupComponent implements OnInit {

  @Input() group!: Group;
  ize = 1;
  poszts?: Poszt[];
  tulaj?: User;
  subscription: Subscription;
  currentUser?: User;
  members?: User[];

  constructor(private _Activatedroute: ActivatedRoute,
    private groupService: GroupService,
    private posztService: PosztService,
    private userService: UserService,
    public dialog: MatDialog
    ) {
      this.subscription = this.userService.userSource.subscribe(user => this.currentUser = user);
    }

  ngOnInit(): void {
    this._Activatedroute.paramMap.subscribe(params => {
      this.getGroup(Number(params.get("id")));
    });
  }

  getGroup(id: number): void {
    this.groupService.getGroupById(id).subscribe(group => {
      this.group = group;
      this.getTulaj(group.tulaj_id);
      this.getPoszts(Number(group.csoport_id));
    })
  }

  getTulaj(id: number): void {
    this.userService.getUserByID(id).subscribe(user => {
      this.tulaj = user;
    });
  }

  getPoszts(id: number): void {
    this.posztService.getPosztsByCsoportId(id).subscribe(poszts => {
      this.poszts = poszts;
      console.log(poszts);
    });
  }


  joinGroup(id: number): void {
    console.log("csoport id: " + id + "| felhasználó id: " + this.currentUser?.id);
    this.userService.joinGroup(id, Number(this.currentUser?.id)).subscribe(ret => {
      //console.log("jeay")
    });
  }

  openPosztDialog(){
    const dialogRef = this.dialog.open(ModalPosztComponent, {
      width: '40%',
      data: {szerzo_id : this.currentUser?.id, szerzo_nev: this.currentUser?.knev+ " "+this.currentUser?.vnev, szerzo_profilkep: this.currentUser?.picture, csoport_id:this.group.csoport_id, felhasznalo_id:undefined}
    });

    dialogRef.afterClosed().subscribe(result => {
      // console.log('The dialog was closed');
    });
  }

  openKommentDialog(val_id: number): void {
    const dialogRef = this.dialog.open(ModalKommentComponent, {
      width: '40%',
      data: {komment_iro_id : this.currentUser?.id, poszt_id: Number(val_id), poszt_idopont: ""}
    });

    dialogRef.afterClosed().subscribe(result => {
    });
  }


  isLoggedIn() {
    return this.currentUser == undefined;
  }

}
