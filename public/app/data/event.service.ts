import {Injectable} from 'angular2/core';

import {Observable} from 'rxjs/Observable';

import {VisualTalesHttpService} from './data';

@Injectable()
export class EventService {
  constructor(private _visualTalesHttp:VisualTalesHttpService<IEvent>) {
    _visualTalesHttp.setUrl('events');
  }

  updateEvent(payload:any):Observable<IEvent>{
    return this._visualTalesHttp.update(payload);
  }
  
  deleteEvent(id:number):Observable<{}>{
    return this._visualTalesHttp.delete(id);
  }
}

export interface IEvent{
  id?:number;
  order:number;
  positionX?:number;
  positionY?:number;
  pose_id?:number;
}