import { PosztService } from './../../services/poszt.service';
import { ModalPosztComponent } from './../modal-poszt/modal-poszt.component';
import { MatDialog } from '@angular/material/dialog';
import { UserService } from 'src/app/services/user.service';
import { User } from './../../shared/models/user.model';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Poszt } from 'src/app/shared/models/poszt.model';

@Component({
  selector: 'app-display-user',
  templateUrl: './display-user.component.html',
  styleUrls: ['./display-user.component.scss']
})
export class DisplayUserComponent implements OnInit {

  @Input() user!: User;
  poszts?: Poszt[];

  constructor(
    private _Activatedroute: ActivatedRoute,
    private userService: UserService,
    private posztService: PosztService,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    this._Activatedroute.paramMap.subscribe(params => {
      this.getUser(Number(params.get("id")));
      this.getPoszts(Number(params.get("id")));
    });

  }

  getUser(id: number): void {
    this.userService.getUserByID(id).subscribe(user => {
      this.user = user;
      console.log(this.user);
    });
  }

  getPoszts(id: number): void {
    this.posztService.getPosztsByFelhasznaloId(id).subscribe(poszts => {
      this.poszts = poszts;
      console.log(poszts);
    });
  }

  getDate(): number {
    if (!this.user) return 0;
    return this.user.csatl.getTime();
  }

  openDialog(){

    const dialogRef = this.dialog.open(ModalPosztComponent, {
      width: '40%',
      //Ide kellene Deny, és a bejelentkezése
      data: {szerzo_id : sessionStorage.getItem("email"), szerzo_nev: sessionStorage.getItem("vnev") + " " + sessionStorage.getItem("knev"), szerzo_profilkep: "", csoport_id:undefined, felhasznalo_id:this.user.id}
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }
}
