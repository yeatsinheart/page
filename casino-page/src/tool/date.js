import dayjs from "dayjs";

import isoWeek  from 'dayjs/plugin/isoWeek';//一周的第一天是星期一（Monday）。
dayjs.extend(isoWeek);

import utc from "dayjs/plugin/utc";
import timezone from "dayjs/plugin/timezone";
dayjs.extend(utc);
dayjs.extend(timezone);
// 业主运营时区 放到localstorage
const gmtString = "GMT+08:00";
const offsetMinutes = parseInt(gmtString.replace("GMT", "").replace(":", "")) * 60 / 100;
const timeWithOffset = dayjs().utcOffset(offsetMinutes);

// 按照当前机器时区
export const dateFormat = (row, column, cellValue, index) => {
    //return dayjs(cellValue).format('YYYY-MM-DD')
    if(cellValue){
        return dayjs(cellValue).format('YYYY-MM-DD HH:mm:ss')
    }
    return null;
}

export const shortcuts = [
    {
        text: '上月',
        value: () => {
            let start = dayjs().subtract(1, 'month').startOf('month').toDate(); // 本月第一天 0:00
            let end = dayjs().subtract(1, 'month').endOf('month').toDate();     // 本月最后一天 23:59:59.999
            return [start, end]
        },
    },
    {
        text: '上周',
        value: () => {
            let end = dayjs().subtract(1, 'week').endOf('isoWeek').toDate()
            let start = dayjs().subtract(1, 'week').startOf('isoWeek').toDate()
            return [start, end]
        },
    },
    {
        text: '昨天',
        value: () => {
            let end = dayjs().subtract(1, 'day').endOf('day').toDate()
            let start = dayjs().subtract(1, 'day').startOf('day').toDate()
            return [start, end]
        },
    },
    {
        text: '今天',
        value: () => {
            let end = dayjs().endOf('day').toDate()
            let start = dayjs().startOf('day').toDate()
            return [start, end]
        },
    },
    {
        text: '本周',
        value: () => {
            let end = dayjs().endOf('isoWeek').toDate()
            let start = dayjs().startOf('isoWeek').toDate()
            return [start, end]
        },
    },

    {
        text: '本月',
        value: () => {
            let start = dayjs().startOf('month').toDate(); // 本月第一天 0:00
            let end = dayjs().endOf('month').toDate();     // 本月最后一天 23:59:59.999
            return [start, end]
        },
    },

]