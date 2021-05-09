import { UserService } from 'src/app/services/user.service';
import { GroupService } from './../../services/group.service';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Group } from 'src/app/shared/models/group.model';
import { Poszt } from 'src/app/shared/models/poszt.model';
import { PosztService } from 'src/app/services/poszt.service';
import { User } from 'src/app/shared/models/user.model';
import { Subscription } from 'rxjs';

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
    ) {
      this.subscription = this.userService.userSource.subscribe(user => this.currentUser = user);
    }

  ngOnInit(): void {
    this._Activatedroute.paramMap.subscribe(params => {
      this.getGroup(Number(params.get("id")));
      this.getMembers(Number(params.get("id")));
    });
  }

  getTulaj(id: number): void {
    this.userService.getUserByID(id).subscribe(user => {
      this.tulaj = user;
      console.log(this.tulaj);
    });
  }

  getGroup(id: number): void {
    this.groupService.getGroupById(id).subscribe(group => {
      this.group = group;
      this.getTulaj(group.tulaj_id);
    })
  }

  getPoszts(id: number): void {
    this.posztService.getPosztsByCsoportId(id).subscribe(poszts => {
      this.poszts = poszts;
      //console.log(poszts);
    });
  }

  getMembers(id: number): void {
    this.groupService.getMembers(id).subscribe(members => {
      this.members = members;
    });
  }

  joinGroup(id: number): void {
    console.log("csoport id: " + id + "| felhasználó id: " + this.currentUser?.id);
    this.userService.joinGroup(id, Number(this.currentUser?.id)).subscribe(ret => {
      //console.log("jeay")
    });
  }
}
