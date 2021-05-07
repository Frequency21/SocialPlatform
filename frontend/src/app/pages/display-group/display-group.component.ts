import { GroupService } from './../../services/group.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Group } from 'src/app/shared/models/group.model';

@Component({
  selector: 'app-display-group',
  templateUrl: './display-group.component.html',
  styleUrls: ['./display-group.component.scss']
})
export class DisplayGroupComponent implements OnInit {

  group?: Group[];
  ize = 1;
  poszts?: Poszt[];

  constructor(private _Activatedroute: ActivatedRoute, private groupService: GroupService) { }

  ngOnInit(): void {
    this._Activatedroute.paramMap.subscribe(params => {
      this.getGroup(Number(params.get("id")));
    });
  }

  getGroup(id: Number): void {
    this.groupService.getGroupById(id).subscribe(group => {
      this.group = group;
      console.log(this.group);
    })
  }

  getPoszts(id: number): void {
    this.posztService.getPosztsByCsoportId(id).subscribe(poszts => {
      this.poszts = poszts;
      console.log(poszts);
    });
  }

}
