import {view_get_by_path} from "@/init/file.js";

const popMap = shallowRef(new Map()); // 🚀 维护所有弹出组件的 Map

export default  defineComponent({
    name: 'pop-page',
    setup() {},
    errorCaptured(err, instance, info) {
        console.error("❌ pop组件报错:", err, info);
        return false; // 阻止 Vue 继续抛出错误
    },
    render() {
        return h('div', {},
            Array.from(popMap.value.values()).map((view, index, array) =>
                h('div', {
                    class: 'new-page',
                    style: index === array.length - 1 ? '' : 'height:0;width:0;opacity: 0;overflow: hidden;left:-9999px;'
                }, h(view.component, { props: view.params, on: view.event }))
            )
        );
    }
});
function close_container(container) {
    let key = [...popMap.value].find(([k, item]) => item.component?.name === container.name)?.[0];
    if (key) close_container_by_key(key);
}

function close_container_by_key(key) {
    if (popMap.value.has(key)) {
        popMap.value.delete(key);
        popMap.value = new Map(popMap.value); // 触发 Vue 响应式更新
    }
}

export function destroy_pop() {
    close_container_by_key(popMap.value.keys().next().value);
}

function pop_container_for_close(async_view, reactiveParams) {
    let container = defineComponent({
        name: "close-listener-container:" + new Date().getTime(),
        errorCaptured(err) {
            console.error("❌ pop组件报错:", err);
            close_container(container);
            return false;
        },
        setup() {
            return () => h(async_view.default, { params: reactiveParams, onDestroy: () => close_container(container) });
        }
    });
    return container;
}

export async function pop_by_container(container_path, view_path, params={}, name, event) {
    if (container_path) {
        const async_view = await view_get_by_path(container_path)();
        const async_child_view = await view_get_by_path(view_path)();
        push_to_list(container_path + ">" + view_path, async_view, params, event, async_child_view);
    } else {
        await pop_view(view_path, params, name, event);
    }
}

export async function pop_view(view_path, params={}, name, event) {
    const async_view = await view_get_by_path(view_path)();
    push_to_list(view_path, async_view, params, event);
}

function push_to_list(key, async_view, params, event, child) {
    let reactiveParams = isRef(params) ? params : ref(params || {});
    let closeable_pop_container = pop_container_for_close(async_view, reactiveParams);
    if (!popMap.value.has(key)) {
        popMap.value.set(key, {
            key,
            component: closeable_pop_container,
            params: child ? { async_component: markRaw(child.default), params: reactiveParams.value } : reactiveParams.value,
            event,
        });
        popMap.value = new Map(popMap.value); // 触发 Vue 响应式更新
    }
}


